using System;
using System.Collections.Generic;

namespace ePozoriste.Services.Database
{
    public partial class Korisnik
    {
        public Korisnik()
        {
            KorisnikUloges = new HashSet<KorisnikUloge>();
            Kupovinas = new HashSet<Kupovina>();
            Obavijests = new HashSet<Obavijest>();
        }

        public int KorisnikId { get; set; }
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public string? KorisnickoIme { get; set; }
        public string? Email { get; set; }
        public string? BrTelefona { get; set; }
        public string? LozinkaHash { get; set; }
        public string? LozinkaSalt { get; set; }
        public bool? Aktivan { get; set; }

        public virtual ICollection<KorisnikUloge> KorisnikUloges { get; set; } 
        public virtual ICollection<Kupovina> Kupovinas { get; set; }
        public virtual ICollection<Obavijest> Obavijests { get; set; }
    }
}
