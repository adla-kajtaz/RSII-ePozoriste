using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model
{
    public class Pozoriste
    {
        public int PozoristeId { get; set; }
        public string Naziv { get; set; }
        public string Adresa { get; set; }
        public string Webstranica { get; set; }
        public string Email { get; set; }
        public string BrTelefona { get; set; }
        public string? Logo { get; set; }
        public bool Aktivan { get; set; }

        public int? GradId { get; set; }
        public virtual Grad? Grad { get; set; }
    }
}
