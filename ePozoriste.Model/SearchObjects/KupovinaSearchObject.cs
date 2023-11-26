using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model.SearchObjects
{
    public class KupovinaSearchObject : BaseSearchObject
    {
        public int? KorisnikId { get; set; }
        public bool? Placena { get; set; }
    }
}
