using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Services.BaseService
{
    public interface IBaseService <T, TSearch> where T : class where TSearch : class
    {
        IEnumerable<T> GetAll(TSearch search = null);
        T GetById(int id);
    }
}
