using System;
using System.Collections.Generic;

namespace ePozoriste.Services.Database
{
    public partial class Kupovina
    {
        public int KupovinaId { get; set; }
        public int Kolicina { get; set; }
        public int Cijena { get; set; }
        public DateTime? DatumKupovine { get; set; }
        public string? PaymentIntentId { get; set; }
        public bool ? Placena { get; set; }
        public int? KorisnikId { get; set; }
        public virtual Korisnik? Korisnik { get; set; }
        public int? TerminId { get; set; }
        public virtual Termin? Termin { get; set; }
    }
}
