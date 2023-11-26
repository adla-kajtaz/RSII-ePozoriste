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
    public class PredstavaService : BaseCRUDService<Model.Predstava, Database.Predstava, PredstavaSearchObject, PredstavaInsertRequest, PredstavaInsertRequest>, IPredstavaService
    {
        public PredstavaService(ePozoristeContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<ePozoriste.Services.Database.Predstava> AddInclude(IQueryable<ePozoriste.Services.Database.Predstava> query, PredstavaSearchObject search = null)
        {
            query = query.Include(x => x.VrstaPredstave);
            return base.AddInclude(query, search);
        }

        public override IQueryable<ePozoriste.Services.Database.Predstava> AddFilter(IQueryable<ePozoriste.Services.Database.Predstava> query, PredstavaSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Tekst))
                filteredQuery = filteredQuery.Where(x => x.Naziv.ToLower().Contains(search.Tekst.ToLower()));
            if (search.VrstaPredstaveId != null)
                filteredQuery = filteredQuery.Where(x => x.VrstaPredstaveId == search.VrstaPredstaveId);
            return filteredQuery;
        }

        public override Model.Predstava Delete(int id)
        {
            var entity = _context.Predstavas.Find(id);
            var termini = _context.Termins.Where(e => e.PredstavaId == id).ToList();
            var predGlumac = _context.PredstavaGlumacs.Where(e => e.PredstavaId == id).ToList();

            if (termini != null && termini.Any())
            {
                return null;
            }
            else if (entity == null)
            {
                return null;
            }
            else if (predGlumac != null && predGlumac.Any())
            {

                foreach (var uloga in predGlumac)
                {
                    _context.PredstavaGlumacs.Remove(uloga);
                }
                _context.Predstavas.Remove(entity);
            }
            else
            {
                _context.Predstavas.Remove(entity);
            }

            _context.SaveChanges();
            return _mapper.Map<Model.Predstava>(entity);
        }
    }
}
