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
    public class SalaService : BaseCRUDService <Model.Sala, Database.Sala, SalaSearchObject, SalaInsertRequest, SalaInsertRequest>, ISalaService
    {
        public SalaService(ePozoristeContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<ePozoriste.Services.Database.Sala> AddInclude(IQueryable<ePozoriste.Services.Database.Sala> query, SalaSearchObject search = null)
        {
            query = query.Include(x => x.Pozoriste).Include(x => x.Pozoriste.Grad).Include(x=>x.Pozoriste.Grad.Drzava);
            return base.AddInclude(query, search);
        }

        public override IQueryable<ePozoriste.Services.Database.Sala> AddFilter(IQueryable<ePozoriste.Services.Database.Sala> query, SalaSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Tekst))
                filteredQuery = filteredQuery.Where(x => x.Naziv.ToLower().Contains(search.Tekst.ToLower()));
            if (search.PozoristeId != null)
                filteredQuery = filteredQuery.Where(x => x.PozoristeId == search.PozoristeId);
            return filteredQuery;
        }

        public override Model.Sala Delete(int id)
        {
            var entity = _context.Salas.Find(id);
            var termini = _context.Termins.Where(e => e.SalaId == id).ToList();

            if (termini != null && termini.Any())
            {
                return null;
            }
            else if (entity == null)
            {
                return null;
            }
            else
            {
                _context.Salas.Remove(entity);
            }

            _context.SaveChanges();
            return _mapper.Map<Model.Sala>(entity);
        }
    }
}
