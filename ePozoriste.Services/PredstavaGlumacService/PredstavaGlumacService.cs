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
    public class PredstavaGlumacService : BaseCRUDService<Model.PredstavaGlumac, Database.PredstavaGlumac, PredstavaGlumacSearchObject, PredstavaGlumacInsertRequest, PredstavaGlumacInsertRequest>, IPredstavaGlumacService
    {
        public PredstavaGlumacService(ePozoristeContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<ePozoriste.Services.Database.PredstavaGlumac> AddInclude(IQueryable<ePozoriste.Services.Database.PredstavaGlumac> query, PredstavaGlumacSearchObject search = null)
        {
            query = query.Include(x => x.Predstava).Include(x=>x.Glumac);
            return base.AddInclude(query, search);
        }

        public override IQueryable<ePozoriste.Services.Database.PredstavaGlumac> AddFilter(IQueryable<ePozoriste.Services.Database.PredstavaGlumac> query, PredstavaGlumacSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Tekst))
                filteredQuery = filteredQuery.Where(x => x.NazivUloge.ToLower().Contains(search.Tekst.ToLower()));
            if (search.PredstavaId != null)
                filteredQuery = filteredQuery.Where(x => x.PredstavaId == search.PredstavaId);
            if (search.GlumacId != null)
                filteredQuery = filteredQuery.Where(x => x.GlumacId == search.GlumacId);
            return filteredQuery;
        }

        public override Model.PredstavaGlumac Delete(int id)
        {
            var entity = _context.PredstavaGlumacs.Find(id);
            var glumci = _context.PredstavaGlumacs.Where(e => e.PredstavaId == entity!.PredstavaId).ToList();

            if (entity == null)
            {
                return null;
            }
            else if (glumci.Count() == 1)
            {
                return null;
            }
            else
            {
                _context.PredstavaGlumacs.Remove(entity);
            }

            _context.SaveChanges();
            return _mapper.Map<Model.PredstavaGlumac>(entity);
        }
    }
}
