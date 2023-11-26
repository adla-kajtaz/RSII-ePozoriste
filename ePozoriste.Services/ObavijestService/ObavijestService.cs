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
    public class ObavijestService : BaseCRUDService<Model.Obavijest, Database.Obavijest, ObavijestSearchObject, ObavijestInsertRequest, ObavijestInsertRequest>, IObavijestService
    {
        public ObavijestService(ePozoristeContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<ePozoriste.Services.Database.Obavijest> AddInclude(IQueryable<ePozoriste.Services.Database.Obavijest> query, ObavijestSearchObject search = null)
        {
            query = query.Include(x => x.ObavijestKategorija).Include(x => x.Korisnik);
            return base.AddInclude(query, search);
        }

        public override IQueryable<ePozoriste.Services.Database.Obavijest> AddFilter(IQueryable<ePozoriste.Services.Database.Obavijest> query, ObavijestSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Tekst))
                filteredQuery = filteredQuery.Where(x => x.Naslov.ToLower().Contains(search.Tekst.ToLower()));
            if (search.ObavijestKategorijaId != null)
                filteredQuery = filteredQuery.Where(x => x.ObavijestKategorijaId == search.ObavijestKategorijaId);
            return filteredQuery;
        }
    }
}
