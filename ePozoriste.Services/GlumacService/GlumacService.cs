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
    public class GlumacService : BaseCRUDService<Model.Glumac, Database.Glumac, BaseSearchObject, GlumacInsertRequest, GlumacInsertRequest>, IGlumacService
    {
        public GlumacService(ePozoristeContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<ePozoriste.Services.Database.Glumac> AddFilter(IQueryable<ePozoriste.Services.Database.Glumac> query, BaseSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Tekst))
                filteredQuery = filteredQuery.Where(x => x.Ime.ToLower().Contains(search.Tekst.ToLower()) || x.Prezime.ToLower().Contains(search.Tekst.ToLower()));
            return filteredQuery;
        }

        public override Model.Glumac Delete(int id)
        {
            var entity = _context.Glumacs.Find(id);
            var glumciPredstave = _context.PredstavaGlumacs.Where(e => e.GlumacId == id).ToList();

            if (glumciPredstave != null && glumciPredstave.Any())
            {
                return null;
            }
            else if (entity == null)
            {
                return null;
            }
            else
            {
                _context.Glumacs.Remove(entity);
            }

            _context.SaveChanges();
            return _mapper.Map<Model.Glumac>(entity);
        }
    }
}
