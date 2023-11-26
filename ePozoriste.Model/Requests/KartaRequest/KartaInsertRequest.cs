using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model.Requests
{
    public class KartaInsertRequest
    {
        [Required]
        public bool Aktivna { get; set; }

        [Required]
        public int? TerminId { get; set; }

        [Required]
        public int BrojSjedista { get; set; }

        [MaxLength(1)]
        [Required]
        public string BrojReda { get; set; }

        [MinLength(2)]
        [Required]
        public string Sjediste { get; set; }

        public int? KupovinaId { get; set; }    

    }
}
