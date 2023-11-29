﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model.Requests
{
    public class DrzavaInsertRequest
    {
        [Required(AllowEmptyStrings = false)]
        public string Naziv { get; set; }

        [Required(AllowEmptyStrings = false)]
        [MaxLength(3, ErrorMessage = "Skracenica moze sadrzavati najvise 3 karaktera!")]
        public string Skracenica { get; set; }
    }
}
