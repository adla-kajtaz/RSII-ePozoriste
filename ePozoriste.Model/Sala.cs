using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model
{
    public class Sala
    {
        public int SalaId { get; set; }
        public string Naziv { get; set; }
        public int BrSjedista { get; set; }
        public int BrRedova { get; set; }
        public int BrSjedistaPoRedu { get; set; }

        public int? PozoristeId { get; set; }
        public virtual Pozoriste? Pozoriste { get; set; }

        public override string ToString()
        {
            return Naziv;
        }
    }
}
