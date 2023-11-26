using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Services.BaseService
{
    public interface IBaseCRUDService <T, TSearch, TInsert, TUpdate> : IBaseService <T, TSearch> where T : class where TInsert : class where TSearch : class where TUpdate : class
    {
        T Insert(TInsert insert);
        T Update(int id, TUpdate update);
        T Delete(int id);
    }
}
