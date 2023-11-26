using System;
using System.Collections.Generic;

namespace ePozoriste.Services.Database
{
    public partial class Kartum
    {
        public Kartum()
        {
            
        }

        public int KartaId { get; set; }
        public bool? Aktivna { get; set; }
        public int? TerminId { get; set; }
        public int? BrojSjedista { get; set; }
        public string? BrojReda { get; set; }
        public string? Sjediste { get; set; }
        public int? KupovinaId { get; set; }

        public virtual Kupovina? Kupovina { get; set; }
        public virtual Termin? Termin { get; set; }
    }
}
