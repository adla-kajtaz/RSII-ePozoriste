using AutoMapper;
using ePozoriste.Model;
using ePozoriste.Model.Requests;
using ePozoriste.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Services
{
    public class AuthService : IAuthService
    {
        public ePozoristeContext _context { get; set; }
        public IMapper _mapper { get; set; }
        
        public AuthService(ePozoristeContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Model.Korisnik> Login(LoginRequest request)
        {
            var entity = await _context.Korisniks.Include("KorisnikUloges.Uloga").FirstOrDefaultAsync(x => x.KorisnickoIme == request.KorisnickoIme);

            if (entity == null)
            {
               throw new KorisnikException("Kredencijali nisu ispravni", "Netacno korisnicko ime ili lozinka!");
            }

            var hash = Helper.PasswordHelper.GenerateHash(entity.LozinkaSalt, request.Lozinka);

            if (hash != entity.LozinkaHash)
            {
                throw new KorisnikException("Kredencijali nisu ispravni", "Netacno korisnicko ime ili lozinka!");
            }
            return _mapper.Map<Model.Korisnik>(entity);
        }

        public async Task<Model.Korisnik> Register(KorisnikInsertRequest request)
        {
            var korisnici = _context.Set<Database.Korisnik>().AsQueryable();

            if (korisnici.Any(x => x.KorisnickoIme == request.KorisnickoIme))
            {
                throw new KorisnikException("Korisnicko ime vec postoji", "Postoji korisnik sa tim korisnickim imenom!");
            }

            var entity = _mapper.Map<Database.Korisnik>(request);
            _context.Add(entity);

            entity.LozinkaSalt = Helper.PasswordHelper.GenerateSalt();
            entity.LozinkaHash = Helper.PasswordHelper.GenerateHash(entity.LozinkaSalt, request.Lozinka);
            _context.SaveChanges();

            foreach (var role in request.Uloge)
            {
                Database.KorisnikUloge korisnikUloge = new Database.KorisnikUloge
                {
                    KorisnikId = entity.KorisnikId,
                    UlogaId = role
                };
                _context.KorisnikUloges.Add(korisnikUloge);
            }

            _context.SaveChanges();

            return _mapper.Map<Model.Korisnik>(entity);
        }

        public async Task<Model.Korisnik> LoginAdmin(LoginRequest request)
        {
            bool admin = false;
            var entity = await _context.Korisniks.Include("KorisnikUloges.Uloga").FirstOrDefaultAsync(x => x.KorisnickoIme == request.KorisnickoIme);
            var uloge =  _context.KorisnikUloges.Include(x => x.Uloga).Where(x => x.KorisnikId == entity.KorisnikId).ToList();

            foreach(var uloga in uloge)
            {
                if (uloga.Uloga.Naziv == "Admin")
                {
                    admin = true;
                }
            }

            if (entity == null)
            {
                throw new KorisnikException("Kredencijali nisu ispravni", "Netacno korisnicko ime ili lozinka!");
            }

            var hash = Helper.PasswordHelper.GenerateHash(entity.LozinkaSalt, request.Lozinka);

            if (hash == entity.LozinkaHash)
            {
                if(admin)
                return _mapper.Map<Model.Korisnik>(entity);
            }
           
            throw new KorisnikException("Kredencijali nisu ispravni", "Netacno korisnicko ime ili lozinka!");
        }
    }
}
