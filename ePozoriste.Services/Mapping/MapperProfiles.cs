using AutoMapper;
using ePozoriste.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Services.Mapping
{
    public class MapperProfiles : Profile
    {
        public MapperProfiles()
        {
            CreateMap<Database.Drzava, Model.Drzava>();
            CreateMap<Database.Grad, Model.Grad>();
            CreateMap<Database.Uloga, Model.Uloga>();
            CreateMap<Database.ObavijestKategorija, Model.ObavijestKategorija>();
            CreateMap<Database.Obavijest, Model.Obavijest>();
            CreateMap<Database.Pozoriste, Model.Pozoriste>();
            CreateMap<Database.Sala, Model.Sala>();
            CreateMap<Database.VrstaPredstave, Model.VrstaPredstave>();
            CreateMap<Database.Glumac, Model.Glumac>();
            CreateMap<Database.Predstava, Model.Predstava>();
            CreateMap<Database.Termin, Model.Termin>();
            CreateMap<Database.PredstavaGlumac, Model.PredstavaGlumac>();
            CreateMap<Database.Kartum, Model.Karta>();
            CreateMap<Database.Kupovina, Model.Kupovina>();
            CreateMap<Database.Korisnik, Model.Korisnik>();
            CreateMap<Database.KorisnikUloge, Model.KorisnikUloge>();



            CreateMap<DrzavaInsertRequest, Database.Drzava>();
            CreateMap<GradInsertRequest, Database.Grad>();
            CreateMap<ObavijestKategorijaInsertRequest, Database.ObavijestKategorija>();
            CreateMap<ObavijestInsertRequest, Database.Obavijest>();
            CreateMap<PozoristeInsertRequest, Database.Pozoriste>();
            CreateMap<SalaInsertRequest, Database.Sala>();
            CreateMap<VrstaPredstaveInsertRequest, Database.VrstaPredstave>();
            CreateMap<GlumacInsertRequest, Database.Glumac>();
            CreateMap<PredstavaInsertRequest, Database.Predstava>();
            CreateMap<TerminInsertRequest, Database.Termin>();
            CreateMap<PredstavaGlumacInsertRequest, Database.PredstavaGlumac>();
            CreateMap<KartaInsertRequest, Database.Kartum>();
            CreateMap<KupovinaInsertRequest, Database.Kupovina>();
            CreateMap<KorisnikInsertRequest, Database.Korisnik>();
            CreateMap<KorisnikUpdateRequest, Database.Korisnik>();
            CreateMap<KorisnikUlogeInsertRequest, Database.KorisnikUloge>();



        }
    }
}
