using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model
{
    public class KupovinaNotifikacija
    {
        public int KupovinaNotifikacijaId { get; set; }

        public string Email { get; set; }

        public string NazivPredstave { get; set; }
    }
}
