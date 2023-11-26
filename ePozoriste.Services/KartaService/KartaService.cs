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
    public class KartaService : BaseCRUDService<Model.Karta, Database.Kartum, KartaSearchObject, KartaInsertRequest, KartaInsertRequest>, IKartaService
    {
        public KartaService(ePozoristeContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<ePozoriste.Services.Database.Kartum> AddInclude(IQueryable<ePozoriste.Services.Database.Kartum> query, KartaSearchObject search = null)
        {
            query = query.Include(x => x.Termin).Include(x=>x.Termin.Sala).Include(x=>x.Termin.Sala.Pozoriste).Include(x => x.Termin.Sala.Pozoriste.Grad).Include(x => x.Termin.Sala.Pozoriste.Grad.Drzava).Include(x=>x.Termin.Predstava).Include(x => x.Kupovina);
            return base.AddInclude(query, search);
        }

        public override IQueryable<ePozoriste.Services.Database.Kartum> AddFilter(IQueryable<ePozoriste.Services.Database.Kartum> query, KartaSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Tekst))
                filteredQuery = filteredQuery.Where(x => x.Sjediste.Contains(search.Tekst));
            if (search.TerminId != null)
                filteredQuery = filteredQuery.Where(x => x.TerminId == search.TerminId);
            if (search.Aktivan != null)
                filteredQuery = filteredQuery.Where(x => x.Aktivna == search.Aktivan);
            return filteredQuery;
        }

        public override Model.Karta Delete(int id)
        {
            var entity = _context.Karta.Find(id);

            if (entity == null)
            {
                return null;
            }
            else
            {
                _context.Karta.Remove(entity);
            }

            _context.SaveChanges();
            return _mapper.Map<Model.Karta>(entity);
        }

        public Model.Karta ChangeStatus(int id, int KupovinaId)
        {
            var entity = _context.Karta.Find(id);
            var kupovina = _context.Kupovinas.Find(KupovinaId);
            if (entity == null)
                return null;
            else
            {
                entity.Aktivna = false;
                entity.KupovinaId = KupovinaId;
                if (kupovina != null)
                    kupovina.Placena = true;
            }
            _context.SaveChanges();
            return _mapper.Map<Model.Karta>(entity);
        }

        public IEnumerable<Model.Karta> GetByTerminId(int id)
        {
            var entity = _context.Karta.Include(x => x.Termin).Include(x => x.Termin.Predstava).Include(x => x.Termin.Sala).Include(x => x.Termin.Sala.Pozoriste).Include(x => x.Termin.Sala.Pozoriste.Grad).Include(x => x.Termin.Sala.Pozoriste.Grad.Drzava).Include(x => x.Kupovina).Where(x=>x.TerminId == id).AsQueryable();
            var list = entity.ToList();
            return _mapper.Map<IList<Model.Karta>>(list);
        }

    }
}
