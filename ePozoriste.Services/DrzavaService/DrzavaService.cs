using AutoMapper;
using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services.BaseService;
using ePozoriste.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Services
{
    public class DrzavaService : BaseCRUDService<Model.Drzava, Database.Drzava, BaseSearchObject, DrzavaInsertRequest, DrzavaInsertRequest>, IDrzavaService
    {
        public DrzavaService(ePozoristeContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<ePozoriste.Services.Database.Drzava> AddFilter(IQueryable<ePozoriste.Services.Database.Drzava> query, BaseSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Tekst))
                filteredQuery = filteredQuery.Where(x => x.Naziv.ToLower().Contains(search.Tekst.ToLower()));
            return filteredQuery;
        }

        public override Model.Drzava Delete(int id)
        {
            var entity = _context.Drzavas.Find(id);
            var gradovi = _context.Grads.Where(e => e.DrzavaId == id).ToList();

            if(gradovi != null && gradovi.Any())
            {
                return null;
            }
            else if (entity == null)
            {
                return null;
            }
            else
            {
                _context.Drzavas.Remove(entity);
            }

            _context.SaveChanges();
            return _mapper.Map<Model.Drzava>(entity);
        }
    }
}
