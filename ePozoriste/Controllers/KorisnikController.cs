using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ePozoriste.Controllers
{
    public class KorisnikController : BaseCRUDController<Model.Korisnik, BaseSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>
    {
        public IKorisnikService _service { get; set; }
        public KorisnikController(IKorisnikService service) : base(service)
        {
            _service = service;
        }

        [Authorize]
        public override Model.Korisnik Insert([FromBody] KorisnikInsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize]
        public override Model.Korisnik Update(int id, [FromBody] KorisnikUpdateRequest request)
        {
            return base.Update(id,request);
        }
    }
}
