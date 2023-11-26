using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model.Requests
{
    public class SalaInsertRequest
    {
        [Required(AllowEmptyStrings = false)]
        public string Naziv { get; set; }

        [Required]
        public int BrSjedista { get; set; }

        [Required]
        public int BrRedova { get; set; }

        [Required]
        public int BrSjedistaPoRedu { get; set; }

        [Required]
        public int PozoristeId { get; set; }
    }
}
