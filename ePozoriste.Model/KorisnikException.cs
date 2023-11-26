using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Model
{
    public class KorisnikException : Exception
    {
        public string Title { get; set; }   

        public KorisnikException(string title, string message) : base(message)
        {
            Title = title;
        }
    }
}
