using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services;

namespace ePozoriste.Controllers
{

    public class SalaController : BaseCRUDController <Model.Sala, SalaSearchObject, SalaInsertRequest, SalaInsertRequest>
    {
        public ISalaService _service { get; set; }
        public SalaController(ISalaService service) : base(service)
        {
            _service = service;
        }
    }
}
