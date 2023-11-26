using System;
using System.Collections.Generic;

namespace ePozoriste.Services.Database
{
    public partial class Glumac
    {
        public Glumac()
        {
            PredstavaGlumacs = new HashSet<PredstavaGlumac>();
        }

        public int GlumacId { get; set; }
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public string? ImePrezime { get; set; }

        public virtual ICollection<PredstavaGlumac> PredstavaGlumacs { get; set; }
    }
}
