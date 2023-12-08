using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ePozoriste.Controllers
{
    public class PredstavaController : BaseCRUDController<Model.Predstava, PredstavaSearchObject, PredstavaInsertRequest, PredstavaInsertRequest>
    {
        public IPredstavaService _service { get; set; }
        public PredstavaController(IPredstavaService service) : base(service)
        {
            _service = service;
        }

        [Authorize]
        [HttpGet("zaradaReport/{id}")]
        public Model.Zarada ZaradaReport(int id)
        {
            return _service.ZaradaReport(id);
        }
    }
}
