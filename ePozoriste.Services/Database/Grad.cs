using System;
using System.Collections.Generic;

namespace ePozoriste.Services.Database
{
    public partial class Grad
    {
        public Grad()
        {
            Pozoristes = new HashSet<Pozoriste>();
        }

        public int GradId { get; set; }
        public string? Naziv { get; set; }
        public string? PostanskiBr { get; set; }
        public int? DrzavaId { get; set; }

        public virtual Drzava? Drzava { get; set; }
        public virtual ICollection<Pozoriste> Pozoristes { get; set; }
    }
}
