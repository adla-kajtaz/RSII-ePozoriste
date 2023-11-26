using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model
{
    public class Predstava
    {
        public int PredstavaId { get; set; }
        public string Naziv { get; set; }
        public string Sadrzaj { get; set; }
        public string? Slika { get; set; }
        public int VrijemeTrajanje { get; set; }
        public string Rezija { get; set; }
        public string Scenografija { get; set; }
        public string Kostimografija { get; set; }
        public int? VrstaPredstaveId { get; set; }
        public VrstaPredstave? VrstaPredstave { get; set; }

        public override string ToString()
        {
            return Naziv;
        }
    }
}
