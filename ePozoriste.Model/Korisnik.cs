using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model
{
    public class Korisnik
    {
        public int KorisnikId { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string KorisnickoIme { get; set; }
        public string Email { get; set; }
        public string BrTelefona { get; set; }
        public bool Aktivan { get; set; }
        public virtual ICollection<KorisnikUloge> KorisnikUloges { get; set; }
        public string ImePrezime => $"{Ime} {Prezime}";

        public override string ToString()
        {
            return KorisnickoIme;
        }

    }
}
