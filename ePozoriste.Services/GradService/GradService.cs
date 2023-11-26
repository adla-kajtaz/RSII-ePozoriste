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
    public class GradService : BaseCRUDService <Model.Grad, Database.Grad, GradSearchObject, GradInsertRequest, GradInsertRequest>, IGradService
    {
        public GradService(ePozoristeContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<ePozoriste.Services.Database.Grad> AddInclude(IQueryable<ePozoriste.Services.Database.Grad> query, GradSearchObject search = null)
        {
            query = query.Include(x => x.Drzava);
            return base.AddInclude(query, search);
        }

        public override IQueryable<ePozoriste.Services.Database.Grad> AddFilter(IQueryable<ePozoriste.Services.Database.Grad> query, GradSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Tekst))
                filteredQuery = filteredQuery.Where(x => x.Naziv.ToLower().Contains(search.Tekst.ToLower()));
            if (search.DrzavaId != null)
                filteredQuery = filteredQuery.Where(x => x.DrzavaId == search.DrzavaId);
            return filteredQuery;
        }

        public override Model.Grad Delete(int id)
        {
            var entity = _context.Grads.Find(id);
            var pozorista = _context.Pozoristes.Where(e => e.GradId == id).ToList();

            if (pozorista != null && pozorista.Any())
            {
                return null;
            }
            else if (entity == null)
            {
                return null;
            }
            else
            {
                _context.Grads.Remove(entity);
            }

            _context.SaveChanges();
            return _mapper.Map<Model.Grad>(entity);
        }
    }
}
