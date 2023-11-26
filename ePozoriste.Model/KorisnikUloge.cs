using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model
{
    public class KorisnikUloge
    {
        public int KorisnikUlogeId { get; set; }
        public int? UlogaId { get; set; }
        public int? KorisnikId { get; set; }
        public virtual Uloga Uloga { get; set; }
    }
}
