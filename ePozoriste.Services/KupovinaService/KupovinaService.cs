using AutoMapper;
using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services.BaseService;
using ePozoriste.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Services
{
    public class KupovinaService : BaseCRUDService<Model.Kupovina, Database.Kupovina, KupovinaSearchObject, KupovinaInsertRequest, KupovinaInsertRequest>, IKupovinaService
    {
        IKartaService _kartaService { get; set; }
        public StripeService _stripeService { get; set; }

        public KupovinaService(ePozoristeContext context, IMapper mapper, IKartaService kartaService, StripeService stripeService) : base(context, mapper)
        {
            _kartaService = kartaService;
            _stripeService = stripeService;
        }

        public override IQueryable<ePozoriste.Services.Database.Kupovina> AddInclude(IQueryable<ePozoriste.Services.Database.Kupovina> query, KupovinaSearchObject search = null)
        {
            query = query.Include(x => x.Korisnik).Include(x=>x.Termin).Include(x=>x.Termin.Predstava).Include(x => x.Termin.Predstava.VrstaPredstave).Include(x => x.Termin.Sala).Include(x => x.Termin.Sala.Pozoriste).Include(x => x.Termin.Sala.Pozoriste.Grad).Include(x => x.Termin.Sala.Pozoriste.Grad.Drzava);
            return base.AddInclude(query, search);
        }

        public override IQueryable<ePozoriste.Services.Database.Kupovina> AddFilter(IQueryable<ePozoriste.Services.Database.Kupovina> query, KupovinaSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search.KorisnikId != null)
                filteredQuery = filteredQuery.Where(x => x.KorisnikId == search.KorisnikId);
            if (search.Placena != null)
                filteredQuery = filteredQuery.Where(x => x.Placena == search.Placena);
            return filteredQuery;
        }

        public override Model.Kupovina Insert(KupovinaInsertRequest request)
        {
            var termin = _context.Termins.First(x => x.TerminId == request.TerminId);
            if (termin == null)
                throw new Exception("Termin nije pronađen");

            Kupovina kupovina = new Kupovina();
            kupovina.KorisnikId = (int)request.KorisnikId;
            kupovina.DatumKupovine = DateTime.Now;
            kupovina.Kolicina = request.Karte.Count();
            kupovina.Cijena = request.Cijena;
            kupovina.TerminId = request.TerminId;
            kupovina.Placena = false;
            _context.Add(kupovina);
            _context.SaveChanges();

            var paymentId =  _stripeService.KreirajKupoivnu(kupovina.Cijena, $"Kupovina za ({kupovina.DatumKupovine})");
            kupovina.PaymentIntentId = paymentId; 
            _context.SaveChanges();
            return _mapper.Map<Model.Kupovina>(kupovina);
        }

        public IEnumerable<Model.Kupovina> GetByKorisnikId(int id)
        {
            var entity = _context.Kupovinas.Include(x => x.Termin).Include(x => x.Termin.Predstava).Include(x => x.Termin.Predstava.VrstaPredstave).Include(x => x.Termin.Sala).Include(x => x.Termin.Sala.Pozoriste).Include(x => x.Termin.Sala.Pozoriste.Grad).Include(x => x.Termin.Sala.Pozoriste.Grad.Drzava).Include(x => x.Korisnik).Where(x => x.KorisnikId == id).Where(x=>x.Placena == true).OrderByDescending(k=>k.DatumKupovine).AsQueryable();
            var list = entity.ToList();
            return _mapper.Map<IList<Model.Kupovina>>(list);
        }
    }
}
