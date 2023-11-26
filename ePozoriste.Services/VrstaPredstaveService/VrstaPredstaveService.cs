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
    public class VrstaPredstaveService : BaseCRUDService<Model.VrstaPredstave, Database.VrstaPredstave, BaseSearchObject, VrstaPredstaveInsertRequest, VrstaPredstaveInsertRequest>, IVrstaPredstaveService
    {
        public VrstaPredstaveService(ePozoristeContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<ePozoriste.Services.Database.VrstaPredstave> AddFilter(IQueryable<ePozoriste.Services.Database.VrstaPredstave> query, BaseSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Tekst))
                filteredQuery = filteredQuery.Where(x => x.Naziv.ToLower().Contains(search.Tekst.ToLower()));
            return filteredQuery;
        }

        public override Model.VrstaPredstave Delete(int id)
        {
            var entity = _context.VrstaPredstaves.Find(id);
            var predstave = _context.Predstavas.Where(e => e.VrstaPredstaveId == id).ToList();
            
            if (predstave != null && predstave.Any())
            {
                return null;
            }
            if (entity == null)
            {
                return null;
            }
            else
            {
                _context.VrstaPredstaves.Remove(entity);
            }

            _context.SaveChanges();
            return _mapper.Map<Model.VrstaPredstave>(entity);
        }
    }
}
