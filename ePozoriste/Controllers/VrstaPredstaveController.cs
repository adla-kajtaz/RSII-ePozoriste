using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services;

namespace ePozoriste.Controllers
{
    public class VrstaPredstaveController : BaseCRUDController<Model.VrstaPredstave, BaseSearchObject, VrstaPredstaveInsertRequest, VrstaPredstaveInsertRequest>
    {
        public IVrstaPredstaveService _service { get; set; }
        public VrstaPredstaveController(IVrstaPredstaveService service) : base(service)
        {
            _service = service;
        }
    }
}
