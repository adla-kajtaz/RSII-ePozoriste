using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services;

namespace ePozoriste.Controllers
{
    public class PozoristeController : BaseCRUDController<Model.Pozoriste, PozoristeSearchObject, PozoristeInsertRequest, PozoristeInsertRequest>
    {
        public IPozoristeService _service { get; set; }
        public PozoristeController(IPozoristeService service) : base(service)
        {
            _service = service;
        }
    }
}
