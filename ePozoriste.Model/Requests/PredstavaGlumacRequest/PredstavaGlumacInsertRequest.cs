using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model.Requests
{
    public class PredstavaGlumacInsertRequest
    {
        [Required]
        public int GlumacId { get; set; }

        [Required]
        public int PredstavaId { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string NazivUloge { get; set; }
    }
}
