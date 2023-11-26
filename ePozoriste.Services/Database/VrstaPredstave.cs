using System;
using System.Collections.Generic;

namespace ePozoriste.Services.Database
{
    public partial class VrstaPredstave
    {
        public VrstaPredstave()
        {
        }

        public int VrstaPredstaveId { get; set; }
        public string? Naziv { get; set; }

    }
}
