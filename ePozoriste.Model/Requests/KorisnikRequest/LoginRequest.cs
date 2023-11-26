using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model.Requests
{
    public class LoginRequest
    {
        [Required]
        [MinLength(4, ErrorMessage = "Korisničko ime mora sadržavati najmanje 4 karaktera!")]
        public string KorisnickoIme { get; set; }

        [Required]
        [MinLength(8, ErrorMessage = "Lozinka mora sadržavati najmanje 8 karaktera!")]
        public string Lozinka { get; set; }
    }
}
