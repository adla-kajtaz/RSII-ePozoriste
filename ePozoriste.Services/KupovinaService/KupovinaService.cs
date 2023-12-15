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
        private readonly INotificationProducer _notificationProducer;
        public StripeService _stripeService { get; set; }

        public KupovinaService(ePozoristeContext context, IMapper mapper, IKartaService kartaService, StripeService stripeService, INotificationProducer notificationProducer) : base(context, mapper)
        {
            _kartaService = kartaService;
            _stripeService = stripeService;
            _notificationProducer = notificationProducer;
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

        public Model.Kupovina ChangeTicketStatus(KartaChangeStatus kcs)
        {
            var karte = _context.Karta.Where(x=> kcs.ListaKarta.Contains(x.KartaId));
            var kupovina = _context.Kupovinas.Include(x=>x.Korisnik).Include(x=>x.Termin).ThenInclude(x=>x.Predstava).FirstOrDefault(x=> x.KupovinaId == kcs.KupovinaId);
            if (karte == null)
                return null;
            else
            {
                foreach(Kartum karta in karte)
                {
                    karta.Aktivna = false;
                    karta.KupovinaId = kcs.KupovinaId;
                }
                if (kupovina != null)
                    kupovina.Placena = true;
            }
            _context.SaveChanges();

            Model.KupovinaNotifikacija kupovinaNot = new Model.KupovinaNotifikacija
            {
                KupovinaNotifikacijaId = kupovina.KupovinaId,
                NazivPredstave = kupovina.Termin.Predstava.Naziv,
                Email = kupovina.Korisnik.Email
            };
             _notificationProducer.SendingObject(kupovinaNot);

            return _mapper.Map<Model.Kupovina>(kupovina);
        }
    }
}
