using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model.Requests
{
    public class KupovinaInsertRequest
    {
        [Required]
        public int Cijena { get; set; }

        [Required]
        public int? KorisnikId { get; set; }

        [Required]
        public int? TerminId { get; set; }

        public List<int> Karte { get; set; }
    }
}
