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
    public class KorisnikUlogeService : BaseCRUDService<Model.KorisnikUloge, Database.KorisnikUloge, KorisnikUlogeSearchObject, KorisnikUlogeInsertRequest, KorisnikUlogeInsertRequest>, IKorisnikUlogeService
    {
        public KorisnikUlogeService(ePozoristeContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<ePozoriste.Services.Database.KorisnikUloge> AddInclude(IQueryable<ePozoriste.Services.Database.KorisnikUloge> query,KorisnikUlogeSearchObject search = null)
        {
            query = query.Include(x => x.Uloga).Include(x => x.Korisnik);
            return base.AddInclude(query, search);
        }

        public override IQueryable<ePozoriste.Services.Database.KorisnikUloge> AddFilter(IQueryable<ePozoriste.Services.Database.KorisnikUloge> query, KorisnikUlogeSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search.KorisnikId != null)
                filteredQuery = filteredQuery.Where(x => x.KorisnikId == search.KorisnikId);
            if(search.UlogaId != null)
                filteredQuery = filteredQuery.Where(x=>x.UlogaId == search.UlogaId);
            return filteredQuery;
        }
    }
}
