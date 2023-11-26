using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services;

namespace ePozoriste.Controllers
{
    public class PredstavaController : BaseCRUDController<Model.Predstava, PredstavaSearchObject, PredstavaInsertRequest, PredstavaInsertRequest>
    {
        public IPredstavaService _service { get; set; }
        public PredstavaController(IPredstavaService service) : base(service)
        {
            _service = service;
        }
    }
}
