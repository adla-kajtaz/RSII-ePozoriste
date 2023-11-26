using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services;

namespace ePozoriste.Controllers
{
    public class GradController : BaseCRUDController <Model.Grad, GradSearchObject, GradInsertRequest, GradInsertRequest>
    {
        public IGradService _service { get; set; }
        public GradController(IGradService service) : base(service)
        {
            _service = service;
        }
    }
}
