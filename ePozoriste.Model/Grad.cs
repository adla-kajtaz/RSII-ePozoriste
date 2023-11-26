using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model
{
    public class Grad
    {
        public int GradId { get; set; }
        public string Naziv { get; set; }
        public string PostanskiBr { get; set; }
        public int? DrzavaId { get; set; }
        public virtual Drzava? Drzava { get; set; }

        public override string ToString()
        {
            return Naziv;
        }
    }
}
