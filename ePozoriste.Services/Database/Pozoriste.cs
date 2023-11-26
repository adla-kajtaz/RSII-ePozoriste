using System;
using System.Collections.Generic;

namespace ePozoriste.Services.Database
{
    public partial class Pozoriste
    {
        public Pozoriste()
        {
            Salas = new HashSet<Sala>();
        }

        public int PozoristeId { get; set; }
        public string? Naziv { get; set; }
        public string? Adresa { get; set; }
        public string? Webstranica { get; set; }
        public string? Email { get; set; }
        public string? BrTelefona { get; set; }
        public string? Logo { get; set; }
        public bool? Aktivan { get; set; }
        public int? GradId { get; set; }

        public virtual Grad? Grad { get; set; }
        public virtual ICollection<Sala> Salas { get; set; }
    }
}
