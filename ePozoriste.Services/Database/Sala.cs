using System;
using System.Collections.Generic;

namespace ePozoriste.Services.Database
{
    public partial class Sala
    {
        public Sala()
        {
            Termins = new HashSet<Termin>();
        }

        public int SalaId { get; set; }
        public string? Naziv { get; set; }
        public int? BrSjedista { get; set; }
        public int? BrRedova { get; set; }
        public int? BrSjedistaPoRedu { get; set; }
        public int? PozoristeId { get; set; }

        public virtual Pozoriste? Pozoriste { get; set; }
        public virtual ICollection<Termin> Termins { get; set; }
    }
}
