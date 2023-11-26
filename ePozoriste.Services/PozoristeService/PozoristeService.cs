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
    public class PozoristeService : BaseCRUDService <Model.Pozoriste, Database.Pozoriste, PozoristeSearchObject, PozoristeInsertRequest, PozoristeInsertRequest>, IPozoristeService
    {
        public PozoristeService(ePozoristeContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<ePozoriste.Services.Database.Pozoriste> AddInclude(IQueryable<ePozoriste.Services.Database.Pozoriste> query, PozoristeSearchObject search = null)
        {
            query = query.Include(x => x.Grad).Include(x => x.Grad.Drzava);
            return base.AddInclude(query, search);
        }

        public override IQueryable<ePozoriste.Services.Database.Pozoriste> AddFilter(IQueryable<ePozoriste.Services.Database.Pozoriste> query, PozoristeSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Tekst))
                filteredQuery = filteredQuery.Where(x => x.Naziv.ToLower().Contains(search.Tekst.ToLower()));
            if (search.GradId != null)
                filteredQuery = filteredQuery.Where(x => x.GradId == search.GradId);
            return filteredQuery;
        }
       
        public override Model.Pozoriste Delete(int id)
        {
            var entity = _context.Pozoristes.Find(id);
            var sale = _context.Salas.Where(e => e.PozoristeId == id).ToList();

            if (sale != null && sale.Any())
            {
                return null;
            }
            else if (entity == null)
            {
                return null;
            }
            else
            {
                _context.Pozoristes.Remove(entity);
            }

            _context.SaveChanges();
            return _mapper.Map<Model.Pozoriste>(entity);
        }
    }
}
