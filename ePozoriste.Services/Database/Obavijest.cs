using System;
using System.Collections.Generic;

namespace ePozoriste.Services.Database
{
    public partial class Obavijest
    {
        public int ObavijestId { get; set; }
        public string? Naslov { get; set; }
        public string? Podnaslov { get; set; }
        public string? Sadrzaj { get; set; }
        public string? Slika { get; set; }
        public DateTime? DatumKreiranja { get; set; }
        public int? ObavijestKategorijaId { get; set; }
        public int? KorisnikId { get; set; }

        public virtual Korisnik? Korisnik { get; set; }
        public virtual ObavijestKategorija? ObavijestKategorija { get; set; }
    }
}
