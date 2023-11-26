using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services;

namespace ePozoriste.Controllers
{
    public class PredstavaGlumacController : BaseCRUDController<Model.PredstavaGlumac, PredstavaGlumacSearchObject, PredstavaGlumacInsertRequest, PredstavaGlumacInsertRequest>
    {
        public IPredstavaGlumacService _service { get; set; }
        public PredstavaGlumacController(IPredstavaGlumacService service) : base(service)
        {
            _service = service;
        }
    }
}
