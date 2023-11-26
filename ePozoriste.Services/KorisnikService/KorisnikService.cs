using AutoMapper;
using ePozoriste.Model;
using ePozoriste.Model.Requests;
using ePozoriste.Model.SearchObjects;
using ePozoriste.Services.BaseService;
using ePozoriste.Services.Database;
using Microsoft.AspNetCore.Cryptography.KeyDerivation;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Services
{
    public class KorisnikService : BaseCRUDService<Model.Korisnik, Database.Korisnik, BaseSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>, IKorisnikService
    {
        public KorisnikService(ePozoristeContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<ePozoriste.Services.Database.Korisnik> AddInclude(IQueryable<ePozoriste.Services.Database.Korisnik> query, BaseSearchObject search = null)
        {
            query = query.Include(x => x.KorisnikUloges);
            return base.AddInclude(query, search);
        }

        public override IQueryable<ePozoriste.Services.Database.Korisnik> AddFilter(IQueryable<ePozoriste.Services.Database.Korisnik> query, BaseSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Tekst))
                filteredQuery = filteredQuery.Where(x => x.Ime.ToLower().Contains(search.Tekst.ToLower()) || x.Prezime.ToLower().Contains(search.Tekst.ToLower()) || x.KorisnickoIme.ToLower().Contains(search.Tekst.ToLower()));
            return filteredQuery;
        }

        public override void BeforeInsert(KorisnikInsertRequest insert, Database.Korisnik entity)
        {
            var salt = Helper.PasswordHelper.GenerateSalt();
            entity.LozinkaSalt = salt;
            entity.LozinkaHash = Helper.PasswordHelper.GenerateHash(salt, insert.Lozinka);
            base.BeforeInsert(insert, entity);
        }

        public override Model.Korisnik Insert(KorisnikInsertRequest request)
        {
            var korisnici = _context.Set<Database.Korisnik>().AsQueryable();

            if (korisnici.Any(x => x.KorisnickoIme == request.KorisnickoIme))
            {
                throw new KorisnikException("Korisnicko ime vec postoji", "Postoji korisnik sa tim korisnickim imenom!");
            }

            var entity = base.Insert(request);

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

            return entity;
        }
        
        public override Model.Korisnik Update(int id, KorisnikUpdateRequest request)
        {
            var korisnikSaKorisnickimImenom = _context.Korisniks.Where(x=>x.KorisnikId != id && x.KorisnickoIme == request.KorisnickoIme).ToList();
            if (korisnikSaKorisnickimImenom != null && korisnikSaKorisnickimImenom.Count > 0)
            {
                throw new KorisnikException("Korisničko ime", "Korisničko ime već postoji!");
            }

            return base.Update(id, request);
        }

        public Model.Korisnik GetByUsername(string korisnickoIme)
        {
            var korisnik = _context.Korisniks.Where(x => x.KorisnickoIme == korisnickoIme).FirstOrDefault();
            return _mapper.Map<Model.Korisnik>(korisnik);
        }

        public override Model.Korisnik Delete(int id)
        {
            var entity = _context.Korisniks.Find(id);
            var korisnikUloge = _context.KorisnikUloges.Where(e => e.KorisnikId == id).ToList();

            if (korisnikUloge != null && korisnikUloge.Any())
            {
                var uloga = _context.KorisnikUloges.Where(e => e.KorisnikId == id).ToList();
                foreach(var ulogaUloge in uloga)
                {
                    _context.KorisnikUloges.Remove(ulogaUloge);
                }
                _context.Korisniks.Remove(entity);
            }
            else if (entity == null)
            {
                return null;
            }
            else
            {
                _context.Korisniks.Remove(entity);
            }
           
            _context.SaveChanges();
            return _mapper.Map<Model.Korisnik>(entity);
        }
    }
}
