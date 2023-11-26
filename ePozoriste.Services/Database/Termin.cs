using System;
using System.Collections.Generic;

namespace ePozoriste.Services.Database
{
    public partial class Termin
    {
        public Termin()
        {
            Karta = new HashSet<Kartum>();
        }

        public int TerminId { get; set; }
        public int? SalaId { get; set; }
        public int? PredstavaId { get; set; }
        public bool? Premijera { get; set; }
        public bool? Predpremijera { get; set; }
        public int? CijenaKarte { get; set; }
        public DateTime DatumOdrzavanja { get; set; }
        public string? VrijemeOdrzavanja { get; set; }

        public virtual Predstava? Predstava { get; set; }
        public virtual Sala? Sala { get; set; }
        public virtual ICollection<Kartum> Karta { get; set; }
    }
}
