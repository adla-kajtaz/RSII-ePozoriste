using ePozoriste.Model.SearchObjects;
using ePozoriste.Services;

namespace ePozoriste.Controllers
{
    public class UlogaController : BaseController<Model.Uloga, BaseSearchObject>
    {
        public UlogaController(IUlogaService service) : base(service)
        {

        }
    }
}
