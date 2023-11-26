using AutoMapper;
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
    public class UlogaService : BaseService <Model.Uloga, Database.Uloga, BaseSearchObject>, IUlogaService
    {
        public UlogaService(ePozoristeContext context, IMapper mapper) : base(context, mapper)
        {

        }
    }
}
