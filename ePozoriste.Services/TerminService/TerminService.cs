using AutoMapper;
using ePozoriste.Model;
using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services.BaseService;
using ePozoriste.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Services
{
    public class TerminService : BaseCRUDService<Model.Termin, Database.Termin, TerminSearchObject, TerminInsertRequest, TerminInsertRequest>, ITerminService
    {
        IKartaService _kartaService { get; set; }

        public TerminService(ePozoristeContext context, IMapper mapper, IKartaService kartaService) : base(context, mapper)
        {
            _kartaService = kartaService;
        }

        public override IQueryable<ePozoriste.Services.Database.Termin> AddInclude(IQueryable<ePozoriste.Services.Database.Termin> query, TerminSearchObject search = null)
        {
            query = query.Include(x => x.Predstava).Include(x=>x.Predstava.VrstaPredstave).Include(x=>x.Sala).Include(x => x.Sala.Pozoriste).Include(x => x.Sala.Pozoriste.Grad).Include(x => x.Sala.Pozoriste.Grad.Drzava);
            return base.AddInclude(query, search);
        }

        public override IQueryable<ePozoriste.Services.Database.Termin> AddFilter(IQueryable<ePozoriste.Services.Database.Termin> query, TerminSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search.PredstavaId != null)
                filteredQuery = filteredQuery.Where(x => x.PredstavaId == search.PredstavaId);
            if (search.SalaId != null)
                filteredQuery = filteredQuery.Where(x => x.SalaId == search.SalaId);
            if (search.Premijera != null)
                filteredQuery = filteredQuery.Where(x => x.Premijera == search.Premijera);
            if (search.Predpremijera != null)
                filteredQuery = filteredQuery.Where(x => x.Predpremijera == search.Predpremijera);
            if (search.DatumOdrzavanja.HasValue)
                filteredQuery = filteredQuery.Where(x => x.DatumOdrzavanja.Date.Equals(search.DatumOdrzavanja.Value.Date));
            if (!string.IsNullOrWhiteSpace(search?.VrijemeOdrzavanja))
                filteredQuery = filteredQuery.Where(x => x.VrijemeOdrzavanja.ToLower().Equals(search.VrijemeOdrzavanja.ToLower()));
            return filteredQuery;
        }
        public override Model.Termin Insert(TerminInsertRequest request)
        {
            var predstava = _context.Predstavas.First(x => x.PredstavaId == request.PredstavaId);
            if (predstava == null)
                throw new Exception("Predstava nije pronađena");
            var sala = _context.Salas.First(x => x.SalaId == request.SalaId); 
            if (sala == null)
                throw new Exception("Sala nije pronađena");

            var termini = _context.Termins.Where(e => e.DatumOdrzavanja.Date == request.DatumOdrzavanja.Date && e.SalaId == request.SalaId && e.VrijemeOdrzavanja.ToLower().Equals(request.VrijemeOdrzavanja.ToLower())).ToList();
            if (termini.Any())
               throw new SalaException("Zauzeta sala", "Sala je zauzeta u tom terminu!");
            else
            {

                var termin = base.Insert(request);
                if (termin != null)
                {
                    for (int i = 0; i < sala.BrRedova; i++)
                    {
                        var red = (char)(i + 65);
                        for (int j = 0; j < sala.BrSjedistaPoRedu; j++)
                        {
                            KartaInsertRequest kartaInsertRequest = new KartaInsertRequest
                            {
                                Aktivna = true,
                                TerminId = termin.TerminId,
                                BrojSjedista = j + 1,
                                BrojReda = red.ToString(),
                                Sjediste = $"{red.ToString()}{(j + 1).ToString()}"
                            };
                            var karta = _kartaService.Insert(kartaInsertRequest);
                        }
                    }
                }
                return termin;
            }
        }

        public override Model.Termin Update(int id, TerminInsertRequest request)
        {
            var termini = _context.Termins.Where(e => e.TerminId != id && e.DatumOdrzavanja.Date == request.DatumOdrzavanja.Date && e.SalaId == request.SalaId && e.VrijemeOdrzavanja.ToLower().Equals(request.VrijemeOdrzavanja.ToLower())).ToList();
            if (termini != null && termini.Count > 0)
                throw new SalaException("Zauzeta sala", "Sala je zauzeta u tom terminu!");
            return base.Update(id, request);
        }

        public override Model.Termin Delete(int id)
        {
            var entity = _context.Termins.Find(id);
            var karte = _context.Karta.Where(e => e.TerminId == id).ToList();

            if (karte != null && karte.Any())
            {
                return null;
            }
            else if (entity == null)
            {
                return null;
            }
            else
            {
                _context.Termins.Remove(entity);
            }

            _context.SaveChanges();
            return _mapper.Map<Model.Termin>(entity);
        }

        static object isLocked = new object();
        static MLContext mlContext = null;
        static ITransformer model = null;

        public List<Model.Termin> TerminRecommenderSystem(int userId)
        {
            var kupovine = _context.Kupovinas
                .Include(p => p.Termin)
                .ThenInclude(p=>p.Sala)
                .ThenInclude(p => p.Pozoriste)
                .Include(p => p.Termin.Predstava)
                .ThenInclude(p=>p.VrstaPredstave)
                .Where(p => p.KorisnikId == userId && p.Placena == true)
                .ToList();

            if (kupovine.Count < 3)
            {
                throw new RecommendationException("Morate imati najmanje 3 kupovine da bismo vam nešto preporučili!");
            }

            lock (isLocked)
            {
                if (mlContext == null)
                {
                    mlContext = new MLContext();

                    var data = new List<VrstaPredstaveEntry>();

                    var vrstaCounts = kupovine
                        .GroupBy(p => p.Termin.Predstava.VrstaPredstaveId)
                        .Select(group => new
                        {
                            VrstaId = group.Key.GetValueOrDefault(),
                            Count = group.Count()
                        }).ToList();

                    foreach (var kupovina in kupovine)
                    {
                        var vrstaCount = vrstaCounts.FirstOrDefault(g => g.VrstaId == kupovina.Termin.Predstava.VrstaPredstaveId.GetValueOrDefault());
                        data.Add(new VrstaPredstaveEntry
                        {
                            KorisnikId = (uint)kupovina.KorisnikId.GetValueOrDefault(),
                            VrstaId = (uint)kupovina.Termin.Predstava.VrstaPredstaveId.GetValueOrDefault(),
                            VrstaCount = vrstaCount.Count
                        });
                    }

                    if (!data.Any())
                    {
                        throw new Exception("Podaci za treniranje su prazni!");
                    }

                    var trainData = mlContext.Data.LoadFromEnumerable(data);
                    var trainTestSplit = mlContext.Data.TrainTestSplit(trainData, testFraction: 0.2);

                    var options = new MatrixFactorizationTrainer.Options
                    {
                        MatrixColumnIndexColumnName = nameof(VrstaPredstaveEntry.KorisnikId),
                        MatrixRowIndexColumnName = nameof(VrstaPredstaveEntry.VrstaId),
                        LabelColumnName = "VrstaCount",
                        LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass,
                        Alpha = 0.01,
                        Lambda = 0.025
                    };

                    var trainer = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                    model = trainer.Fit(trainTestSplit.TrainSet);
                    if (model == null)
                    {
                        throw new Exception("Obuka modela nije uspjela, rezultirajući model je nul.");
                    }
                }
            }

            var predictionResult = new List<Tuple<Database.Termin, float>>();
            var termini = _context.Termins.Include(s => s.Predstava).Include(s=>s.Sala).ToList();

            foreach (var termin in termini)
            {
                var predictionEngine = mlContext.Model.CreatePredictionEngine<VrstaPredstaveEntry, VrstaPredstavePrediction>(model);
                var prediction = predictionEngine.Predict(new VrstaPredstaveEntry()
                {
                    KorisnikId = (uint)userId,
                    VrstaId = (uint)termin.Predstava.VrstaPredstaveId.GetValueOrDefault()
                });

                predictionResult.Add(new Tuple<Database.Termin, float>(termin, prediction.Score));
            }

            var finalResult = predictionResult.OrderByDescending(x => x.Item2)
                .Select(x => x.Item1)
                .ToList()
                .Take(3);

            return _mapper.Map<List<Model.Termin>>(finalResult);
        }

        public class VrstaPredstaveEntry
        {
            [KeyType(count: 10)]
            public uint KorisnikId { get; set; }

            [KeyType(count: 10)]
            public uint VrstaId { get; set; }

            public float VrstaCount { get; set; }
        }

        public class VrstaPredstavePrediction
        {
            [KeyType(count: 10)]
            public uint VrstaId { get; set; }
            public float Score { get; set; }
            public float Label { get; set; }
        }
    }
}
