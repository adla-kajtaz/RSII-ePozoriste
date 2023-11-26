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
    public interface IKartaService : IBaseCRUDService<Model.Karta, KartaSearchObject, KartaInsertRequest, KartaInsertRequest>
    {
        Model.Karta ChangeStatus(int id, int KupovinaId);
        IEnumerable<Model.Karta> GetByTerminId(int id);
    }
}
