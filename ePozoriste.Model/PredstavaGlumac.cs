using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model
{
    public class PredstavaGlumac
    {
        public int PredstavaGlumacId { get; set; }
        public int? GlumacId { get; set; }
        public int? PredstavaId { get; set; }
        public string NazivUloge { get; set; }

        public virtual Glumac? Glumac { get; set; }
        public virtual Predstava? Predstava { get; set; }
    }
}
