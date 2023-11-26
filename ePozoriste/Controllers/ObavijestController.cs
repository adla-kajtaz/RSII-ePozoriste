using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services;

namespace ePozoriste.Controllers
{
    public class ObavijestController : BaseCRUDController<Model.Obavijest, ObavijestSearchObject, ObavijestInsertRequest, ObavijestInsertRequest>
    {
        public IObavijestService _service { get; set; }
        public ObavijestController(IObavijestService service) : base(service)
        {
            _service = service;
        }
    }
}
