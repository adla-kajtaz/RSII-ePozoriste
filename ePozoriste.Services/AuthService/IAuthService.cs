using ePozoriste.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Services
{
    public interface IAuthService
    {
        public Task<Model.Korisnik> Register(KorisnikInsertRequest request);
        public Task<Model.Korisnik> Login(LoginRequest request);
        public Task<Model.Korisnik> LoginAdmin(LoginRequest request);
    }
}
