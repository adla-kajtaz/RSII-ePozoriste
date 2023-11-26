using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model.Requests
{
    public class PredstavaInsertRequest
    {
        [Required(AllowEmptyStrings = false)]
        public string Naziv { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Sadrzaj { get; set; }

        [Required]
        public string Slika { get; set; }

        [Required]
        public int VrijemeTrajanje { get; set; }

        [Required]
        public string Rezija { get; set; }

        [Required]
        public string Scenografija { get; set; }
        
        [Required]
        public string Kostimografija { get; set; }

        [Required]
        public int VrstaPredstaveId { get; set; }
    }
}
