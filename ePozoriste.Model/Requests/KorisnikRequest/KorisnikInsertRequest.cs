using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model.Requests
{
    public class KorisnikInsertRequest
    {
        [Required(AllowEmptyStrings = false)]
        public string Ime { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Prezime { get; set; }

        [Required(AllowEmptyStrings = false)]
        [MinLength(4, ErrorMessage = "Korisničko ime mora sadržavati najmanje 4 karaktera!")]
        public string KorisnickoIme { get; set; }

        [Required(AllowEmptyStrings = false)]
        [EmailAddress()]
        public string Email { get; set; }

        [Required(AllowEmptyStrings = false)]
        [RegularExpression("^\\d{3}-\\d{3}-(\\d{4}|\\d{3})$", ErrorMessage = "Broj telefona mora biti u obliku 06X-XXX-XXX !")]
        public string BrTelefona { get; set; }

        public bool? Aktivan { get; set; }

        [Required]
        [MinLength(8, ErrorMessage = "Lozinka mora sadržavati najmanje 8 karaktera!")]
        public string Lozinka { get; set; }

        public List<int>? Uloge { get; set; } = new List<int>();
    }
}
