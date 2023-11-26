using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services.BaseService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Services
{
    public interface ISalaService : IBaseCRUDService <Model.Sala, SalaSearchObject, SalaInsertRequest, SalaInsertRequest>
    {

    }
}
