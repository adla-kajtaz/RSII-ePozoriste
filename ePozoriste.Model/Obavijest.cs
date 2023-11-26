using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model
{
    public class Obavijest
    {
        public int ObavijestId { get; set; }
        public string Naslov { get; set; }
        public string Podnaslov { get; set; }
        public string Sadrzaj { get; set; }
        public string Slika { get; set; }
        public DateTime DatumKreiranja { get; set; }

        public int? ObavijestKategorijaId { get; set; }
        public virtual ObavijestKategorija? ObavijestKategorija { get; set; }

        public int? KorisnikId { get; set; }
        public virtual Korisnik? Korisnik { get; set; }
        
    }
}
