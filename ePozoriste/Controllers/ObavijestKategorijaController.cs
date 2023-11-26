using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services;

namespace ePozoriste.Controllers
{
    public class ObavijestKategorijaController : BaseCRUDController <Model.ObavijestKategorija, BaseSearchObject, ObavijestKategorijaInsertRequest, ObavijestKategorijaInsertRequest>
    {
        public IObavijestKategorijaService _service { get; set; }
        public ObavijestKategorijaController(IObavijestKategorijaService service) : base(service)
        {
            _service = service;
        }
    }
}
