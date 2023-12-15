using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model.Requests
{
    public class KartaChangeStatus
    {
        [Required]
        public int KupovinaId { get; set; }

        [Required]
        public List<int>? ListaKarta { get; set; } = new List<int>();
    }
}
