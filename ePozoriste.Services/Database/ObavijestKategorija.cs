using System;
using System.Collections.Generic;

namespace ePozoriste.Services.Database
{
    public partial class ObavijestKategorija
    {
        public ObavijestKategorija()
        {
            Obavijests = new HashSet<Obavijest>();
        }

        public int ObavijestKategorijaId { get; set; }
        public string? Naziv { get; set; }

        public virtual ICollection<Obavijest> Obavijests { get; set; }
    }
}
