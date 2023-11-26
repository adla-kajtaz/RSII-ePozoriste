using ePozoriste.Model.Requests;
using ePozoriste.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text;
using System.Text.Encodings.Web;

namespace ePozoriste
{
    public class BasicAuthenticationHandler : AuthenticationHandler<AuthenticationSchemeOptions>
    {
        private readonly IAuthService _service;
        public BasicAuthenticationHandler(IOptionsMonitor<AuthenticationSchemeOptions> options, ILoggerFactory logger, UrlEncoder encoder, ISystemClock clock, IAuthService service) : base(options, logger, encoder, clock)
        {
            _service = service;
        }
        protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
        {
            if (!Request.Headers.ContainsKey("Authorization"))
            {
                return AuthenticateResult.Fail("Missing authorization header");
            }
            Model.Korisnik korisnik;
            try
            {
                var authHeader = AuthenticationHeaderValue.Parse(Request.Headers["Authorization"]);
                var credentialBytes = Convert.FromBase64String(authHeader.Parameter);
                var credentials = Encoding.UTF8.GetString(credentialBytes).Split(':');
                var korisnickoIme = credentials[0];
                var lozinka = credentials[1];

                LoginRequest request = new LoginRequest
                {
                    Lozinka = lozinka,
                    KorisnickoIme = korisnickoIme
                };

                korisnik = await _service.Login(request);
            }
            catch
            {
                return AuthenticateResult.Fail("Netacno korisnicko ime ili lozinka");
            }
            if (korisnik == null)
                return AuthenticateResult.Fail("Netacno korisnicko ime ili lozinka");
            
            var claims = new List<Claim> {
                new Claim(ClaimTypes.NameIdentifier, korisnik.KorisnickoIme),
                new Claim(ClaimTypes.Name, $"{korisnik.Ime} {korisnik.Prezime}"),
            };
            
            foreach (var uloga in korisnik.KorisnikUloges)
            {
                claims.Add(new Claim(ClaimTypes.Role, uloga.Uloga.Naziv));
            }
            
            var identity = new ClaimsIdentity(claims, Scheme.Name);
            var principal = new ClaimsPrincipal(identity);
            var ticket = new AuthenticationTicket(principal, Scheme.Name);
            return AuthenticateResult.Success(ticket);
        }
    }
}
