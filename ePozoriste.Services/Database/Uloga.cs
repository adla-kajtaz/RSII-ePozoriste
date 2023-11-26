using System;
using System.Collections.Generic;

namespace ePozoriste.Services.Database
{
    public partial class Uloga
    {
        public Uloga()
        {
            KorisnikUloges = new HashSet<KorisnikUloge>();
        }

        public int UlogaId { get; set; }
        public string? Naziv { get; set; }

        public virtual ICollection<KorisnikUloge> KorisnikUloges { get; set; }
    }
}
