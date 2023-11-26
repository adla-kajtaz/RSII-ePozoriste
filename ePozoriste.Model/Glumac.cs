using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model
{
    public class Glumac
    {
        public int GlumacId { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string? Slika { get; set; }
        public string ImePrezime { get; set; }


        public override string ToString()
        {
            return ImePrezime;
        }
    }
}
