using ePozoriste.Services.BaseService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ePozoriste.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class BaseCRUDController <T, TSearch, TInsert, TUpdate> : BaseController <T, TSearch> where T : class where TSearch : class where TInsert : class where TUpdate : class
    {
        protected readonly IBaseCRUDService<T, TSearch, TInsert, TUpdate> _service;
        public BaseCRUDController(IBaseCRUDService <T, TSearch, TInsert, TUpdate> service) : base(service)
        {
            _service = service;
        }

        [Authorize]
        [HttpPost]
        public virtual T Insert([FromBody] TInsert insert)
        {
            return _service.Insert(insert);
        }

        [Authorize]
        [HttpPut("{id}")]
        public virtual T Update(int id, [FromBody] TUpdate update)
        {
            return _service.Update(id, update);
        }

        [Authorize]
        [HttpDelete("{id}")]
        public virtual T Delete(int id)
        {
            return _service.Delete(id);
        }
    }
}
