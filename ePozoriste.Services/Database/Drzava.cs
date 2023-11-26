using System;
using System.Collections.Generic;

namespace ePozoriste.Services.Database
{
    public partial class Drzava
    {
        public Drzava()
        {
            Grads = new HashSet<Grad>();
        }

        public int DrzavaId { get; set; }
        public string? Naziv { get; set; }
        public string? Skracenica { get; set; }

        public virtual ICollection<Grad> Grads { get; set; }
    }
}
