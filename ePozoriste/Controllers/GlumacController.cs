using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services;

namespace ePozoriste.Controllers
{
    public class GlumacController : BaseCRUDController <Model.Glumac, BaseSearchObject, GlumacInsertRequest, GlumacInsertRequest>
    {
        public IGlumacService _service { get; set; }
        public GlumacController(IGlumacService service) : base(service)
        {
            _service = service;
        }
    }
}
