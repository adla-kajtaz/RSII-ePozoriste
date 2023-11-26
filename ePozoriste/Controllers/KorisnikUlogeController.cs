using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services;

namespace ePozoriste.Controllers
{
    public class KorisnikUlogeController : BaseCRUDController<Model.KorisnikUloge, KorisnikUlogeSearchObject, KorisnikUlogeInsertRequest, KorisnikUlogeInsertRequest>
    {
        public IKorisnikUlogeService _service { get; set; }
        public KorisnikUlogeController(IKorisnikUlogeService service) : base(service)
        {
            _service = service;
        }
    }
}
