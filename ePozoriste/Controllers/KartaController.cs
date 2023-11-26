using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ePozoriste.Controllers
{
    public class KartaController : BaseCRUDController<Model.Karta, KartaSearchObject, KartaInsertRequest, KartaInsertRequest>
    {
        public IKartaService _service { get; set; }
        public KartaController(IKartaService service) : base(service)
        {
            _service = service;
        }

        [Authorize]
        [HttpPatch("{id}")]
        public Model.Karta changeStatus(int id, int KupovinaId)
        {
            return _service.ChangeStatus(id, KupovinaId);
        }

        [Authorize]
        [HttpGet("getByTerminId/{id}")]
        public IEnumerable<Model.Karta> GetByTerminId(int id)
        {
            return _service.GetByTerminId(id);
        }
    }
}
