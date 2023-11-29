using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model.Requests
{
    public class GradInsertRequest
    {
        [Required(AllowEmptyStrings = false)]
        public string Naziv { get; set; }

        [Required(AllowEmptyStrings = false)]
        [MinLength(5, ErrorMessage = "Postanski broj mora imati 5 karaktera!")]
        [MaxLength(5, ErrorMessage = "Postanski broj mora imati 5 karaktera!")]
        public string PostanskiBr { get; set; }

        [Required]
        public int DrzavaId { get; set; }
    }
}
