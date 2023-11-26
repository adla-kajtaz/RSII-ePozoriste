using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePozoriste.Services.Migrations
{
    public partial class init : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Drzava",
                columns: table => new
                {
                    DrzavaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Skracenica = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Drzava", x => x.DrzavaId);
                });

            migrationBuilder.CreateTable(
                name: "Glumac",
                columns: table => new
                {
                    GlumacId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ImePrezime = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Glumac", x => x.GlumacId);
                });

            migrationBuilder.CreateTable(
                name: "Korisnik",
                columns: table => new
                {
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    BrTelefona = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    LozinkaHash = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Aktivan = table.Column<bool>(type: "bit", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisnik", x => x.KorisnikId);
                });

            migrationBuilder.CreateTable(
                name: "ObavijestKategorija",
                columns: table => new
                {
                    ObavijestKategorijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ObavijestKategorija", x => x.ObavijestKategorijaId);
                });

            migrationBuilder.CreateTable(
                name: "Predstava",
                columns: table => new
                {
                    PredstavaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Sadrzaj = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Slika = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    VrijemeTrajanje = table.Column<int>(type: "int", nullable: true),
                    Rezija = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Scenografija = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Kostimografija = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Predstava", x => x.PredstavaId);
                });

            migrationBuilder.CreateTable(
                name: "Uloga",
                columns: table => new
                {
                    UlogaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Uloga", x => x.UlogaId);
                });

            migrationBuilder.CreateTable(
                name: "VrstaPredstave",
                columns: table => new
                {
                    VrstaPredstaveId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VrstaPredstave", x => x.VrstaPredstaveId);
                });

            migrationBuilder.CreateTable(
                name: "Grad",
                columns: table => new
                {
                    GradId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PostanskiBr = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DrzavaId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Grad", x => x.GradId);
                    table.ForeignKey(
                        name: "FK__Grad__DrzavaId__2E1BDC42",
                        column: x => x.DrzavaId,
                        principalTable: "Drzava",
                        principalColumn: "DrzavaId");
                });

            migrationBuilder.CreateTable(
                name: "Obavijest",
                columns: table => new
                {
                    ObavijestId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naslov = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Podnaslov = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Sadrzaj = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Slika = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DatumKreiranja = table.Column<DateTime>(type: "datetime", nullable: true),
                    ObavijestKategorijaId = table.Column<int>(type: "int", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Obavijest", x => x.ObavijestId);
                    table.ForeignKey(
                        name: "FK__Obavijest__Koris__33D4B598",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                    table.ForeignKey(
                        name: "FK__Obavijest__Obavi__32E0915F",
                        column: x => x.ObavijestKategorijaId,
                        principalTable: "ObavijestKategorija",
                        principalColumn: "ObavijestKategorijaId");
                });

            migrationBuilder.CreateTable(
                name: "PredstavaGlumac",
                columns: table => new
                {
                    PredstavaGlumacId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    GlumacId = table.Column<int>(type: "int", nullable: true),
                    PredstavaId = table.Column<int>(type: "int", nullable: true),
                    NazivUloge = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PredstavaGlumac", x => x.PredstavaGlumacId);
                    table.ForeignKey(
                        name: "FK__Predstava__Gluma__45F365D3",
                        column: x => x.GlumacId,
                        principalTable: "Glumac",
                        principalColumn: "GlumacId");
                    table.ForeignKey(
                        name: "FK__Predstava__Preds__46E78A0C",
                        column: x => x.PredstavaId,
                        principalTable: "Predstava",
                        principalColumn: "PredstavaId");
                });

            migrationBuilder.CreateTable(
                name: "KorisnikUloge",
                columns: table => new
                {
                    KorisnikUlogeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UlogaId = table.Column<int>(type: "int", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisnikUloge", x => x.KorisnikUlogeId);
                    table.ForeignKey(
                        name: "FK__KorisnikU__Koris__29572725",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                    table.ForeignKey(
                        name: "FK__KorisnikU__Uloga__286302EC",
                        column: x => x.UlogaId,
                        principalTable: "Uloga",
                        principalColumn: "UlogaId");
                });

            migrationBuilder.CreateTable(
                name: "PredstavaVrstaPredstave",
                columns: table => new
                {
                    PredstavaVPId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    VrstaPredstaveId = table.Column<int>(type: "int", nullable: true),
                    PredstavaId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Predstav__D51F265A1B68304F", x => x.PredstavaVPId);
                    table.ForeignKey(
                        name: "FK__Predstava__Preds__4AB81AF0",
                        column: x => x.PredstavaId,
                        principalTable: "Predstava",
                        principalColumn: "PredstavaId");
                    table.ForeignKey(
                        name: "FK__Predstava__Vrsta__49C3F6B7",
                        column: x => x.VrstaPredstaveId,
                        principalTable: "VrstaPredstave",
                        principalColumn: "VrstaPredstaveId");
                });

            migrationBuilder.CreateTable(
                name: "Pozoriste",
                columns: table => new
                {
                    PozoristeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Adresa = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Webstranica = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    BrTelefona = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Logo = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Aktivan = table.Column<bool>(type: "bit", nullable: true),
                    GradId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Pozoriste", x => x.PozoristeId);
                    table.ForeignKey(
                        name: "FK__Pozoriste__GradI__36B12243",
                        column: x => x.GradId,
                        principalTable: "Grad",
                        principalColumn: "GradId");
                });

            migrationBuilder.CreateTable(
                name: "Sala",
                columns: table => new
                {
                    SalaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    BrSjedista = table.Column<int>(type: "int", nullable: true),
                    BrRedova = table.Column<int>(type: "int", nullable: true),
                    BrSjedistaPoRedu = table.Column<int>(type: "int", nullable: true),
                    PozoristeId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Sala", x => x.SalaId);
                    table.ForeignKey(
                        name: "FK__Sala__PozoristeI__398D8EEE",
                        column: x => x.PozoristeId,
                        principalTable: "Pozoriste",
                        principalColumn: "PozoristeId");
                });

            migrationBuilder.CreateTable(
                name: "Termin",
                columns: table => new
                {
                    TerminId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    SalaId = table.Column<int>(type: "int", nullable: true),
                    PredstavaId = table.Column<int>(type: "int", nullable: true),
                    Premijera = table.Column<bool>(type: "bit", nullable: true),
                    Predpremijera = table.Column<bool>(type: "bit", nullable: true),
                    CijenaKarte = table.Column<int>(type: "int", nullable: true),
                    DatumOdrzavanja = table.Column<DateTime>(type: "datetime", nullable: true),
                    VrijemeOdrazvanja = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Termin", x => x.TerminId);
                    table.ForeignKey(
                        name: "FK__Termin__Predstav__4316F928",
                        column: x => x.PredstavaId,
                        principalTable: "Predstava",
                        principalColumn: "PredstavaId");
                    table.ForeignKey(
                        name: "FK__Termin__SalaId__4222D4EF",
                        column: x => x.SalaId,
                        principalTable: "Sala",
                        principalColumn: "SalaId");
                });

            migrationBuilder.CreateTable(
                name: "Karta",
                columns: table => new
                {
                    KartaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Aktivna = table.Column<bool>(type: "bit", nullable: true),
                    TerminId = table.Column<int>(type: "int", nullable: true),
                    BrojSjedista = table.Column<int>(type: "int", nullable: true),
                    BrojReda = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Sjediste = table.Column<string>(type: "varchar(max)", unicode: false, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Karta__EC3FA9EE23583A11", x => x.KartaId);
                    table.ForeignKey(
                        name: "FK__Karta__TerminId__4D94879B",
                        column: x => x.TerminId,
                        principalTable: "Termin",
                        principalColumn: "TerminId");
                });

            migrationBuilder.CreateTable(
                name: "Kupovina",
                columns: table => new
                {
                    KupovinaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Kolicina = table.Column<int>(type: "int", nullable: true),
                    Cijena = table.Column<int>(type: "int", nullable: true),
                    DatumKupovine = table.Column<DateTime>(type: "datetime", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: true),
                    KartaId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Kupovina", x => x.KupovinaId);
                    table.ForeignKey(
                        name: "FK__Kupovina__KartaI__5165187F",
                        column: x => x.KartaId,
                        principalTable: "Karta",
                        principalColumn: "KartaId");
                    table.ForeignKey(
                        name: "FK__Kupovina__Korisn__5070F446",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                });

            migrationBuilder.InsertData(
                table: "Drzava",
                columns: new[] { "DrzavaId", "Naziv", "Skracenica" },
                values: new object[,]
                {
                    { 1, "Bosna i Hercegovina", "BiH" },
                    { 2, "Hrvatska", "HR" }
                });

            migrationBuilder.InsertData(
                table: "Glumac",
                columns: new[] { "GlumacId", "Ime", "ImePrezime", "Prezime" },
                values: new object[,]
                {
                    { 1, "Ajla", "Ajla Hamzić", "Hamzić" },
                    { 2, "Emir", "Emir Spahić", "Spahić" }
                });

            migrationBuilder.InsertData(
                table: "Korisnik",
                columns: new[] { "KorisnikId", "Aktivan", "BrTelefona", "Email", "Ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "Prezime" },
                values: new object[] { 1, true, "062-045-456", "admin@epozoriste.ba", "Admin", "admin", "523l3SXvXt/OIGacFmI0PUlXkJM=", "ORNOSgr59Nd5PGJx/GNMKg==", "Admin" });

            migrationBuilder.InsertData(
                table: "ObavijestKategorija",
                columns: new[] { "ObavijestKategorijaId", "Naziv" },
                values: new object[] { 1, "Novosti" });

            migrationBuilder.InsertData(
                table: "Predstava",
                columns: new[] { "PredstavaId", "Kostimografija", "Naziv", "Rezija", "Sadrzaj", "Scenografija", "Slika", "VrijemeTrajanje" },
                values: new object[] { 1, "Sabina Trnka", "Ćelava pjevačica", "Lajla Kaikčija", "“Kao i Jonesko, mi, ekipa predstave željeli smo kroz 'Ćelavu pjevačicu' efektom 'čudnovatog', ironijom, non-sensom, karikaturom izraziti svoj protest protiv društva u kojem živimo i stanja u kome se nalazimo. 'Ćelava pjevačica' ismijava nepresušnu potrebu naroda da stalno govori, o svemu ima mišljenje i bude u toku svih dešavanja - najčešće i najbanalnijih. Govor se dovodi do apsurda. Riječi gube smisao. Misao devalvira. Sve dok glas izlazi iz grla govor ne prestaje. I tako u nedogled. A svaki vid akcije, djelovanja izostaje. I to neko koristi. Jedni iznutra, drugi izvana. Da li govorim o životu ili o predstavi? Svejedno. Na žalost, Joneskov besmisao nigdje nije smislenije postaviti nego u Mostaru. Vođena mišlju da će neki novi klinci po prvi put vidjeti Joneskov komad u teatru i možda biti isprovocirani njime (kakogod) te odluče se, konačno, na neki vid djelovanja... To je jedini način izlaska iz apsurda koji živimo”, zapisala je o predstavi rediteljica Lajla Kaikčija", "Sabina Trnka", null, 45 });

            migrationBuilder.InsertData(
                table: "Uloga",
                columns: new[] { "UlogaId", "Naziv" },
                values: new object[,]
                {
                    { 1, "Admin" },
                    { 2, "Kupac" }
                });

            migrationBuilder.InsertData(
                table: "VrstaPredstave",
                columns: new[] { "VrstaPredstaveId", "Naziv" },
                values: new object[,]
                {
                    { 1, "Drama" },
                    { 2, "Komedija" }
                });

            migrationBuilder.InsertData(
                table: "Grad",
                columns: new[] { "GradId", "DrzavaId", "Naziv", "PostanskiBr" },
                values: new object[,]
                {
                    { 1, 1, "Mostar", "88104" },
                    { 2, 1, "Sarajevo", "71000" }
                });

            migrationBuilder.InsertData(
                table: "KorisnikUloge",
                columns: new[] { "KorisnikUlogeId", "KorisnikId", "UlogaId" },
                values: new object[] { 1, 1, 1 });

            migrationBuilder.InsertData(
                table: "Obavijest",
                columns: new[] { "ObavijestId", "DatumKreiranja", "KorisnikId", "Naslov", "ObavijestKategorijaId", "Podnaslov", "Sadrzaj", "Slika" },
                values: new object[] { 1, new DateTime(2023, 6, 13, 17, 36, 42, 808, DateTimeKind.Local).AddTicks(1209), 1, "Uskoro u prodaji karte za predstavu Ćelava pjevačica", 1, "Uskoro u prodaji karte za predstavu Ćelava pjevačica", "Ulaznice su u prodaji na blagajni NPM-a od ponedjeljka, 5.6.2023. svakim radnim danom od 9 - 14 sati, na dan igranja predstave od 9 do 14 sati te od 18 do 20 sati. Rezervacije: na broj 036/550-128, mail: marketing@npm.ba, porukom u inbox na Facebook stranici Narodnog pozorišta Mostar.", null });

            migrationBuilder.InsertData(
                table: "PredstavaGlumac",
                columns: new[] { "PredstavaGlumacId", "GlumacId", "NazivUloge", "PredstavaId" },
                values: new object[] { 1, 2, "G. Smit", 1 });

            migrationBuilder.InsertData(
                table: "PredstavaVrstaPredstave",
                columns: new[] { "PredstavaVPId", "PredstavaId", "VrstaPredstaveId" },
                values: new object[] { 1, 1, 1 });

            migrationBuilder.InsertData(
                table: "Pozoriste",
                columns: new[] { "PozoristeId", "Adresa", "Aktivan", "BrTelefona", "Email", "GradId", "Logo", "Naziv", "Webstranica" },
                values: new object[] { 1, "Brkića br. 2", true, "036-550-128", "info@npm.ba", 1, null, "Narodno pozoriste Mostar", "https://www.npm.ba/" });

            migrationBuilder.InsertData(
                table: "Sala",
                columns: new[] { "SalaId", "BrRedova", "BrSjedista", "BrSjedistaPoRedu", "Naziv", "PozoristeId" },
                values: new object[] { 1, 15, 300, 15, "Velika sala", 1 });

            migrationBuilder.InsertData(
                table: "Sala",
                columns: new[] { "SalaId", "BrRedova", "BrSjedista", "BrSjedistaPoRedu", "Naziv", "PozoristeId" },
                values: new object[] { 2, 10, 100, 10, "Mala sala", 1 });

            migrationBuilder.InsertData(
                table: "Termin",
                columns: new[] { "TerminId", "CijenaKarte", "DatumOdrzavanja", "Predpremijera", "PredstavaId", "Premijera", "SalaId", "VrijemeOdrazvanja" },
                values: new object[] { 1, 20, new DateTime(2023, 6, 13, 0, 0, 0, 0, DateTimeKind.Local), true, 1, false, 1, "20:00" });

            migrationBuilder.CreateIndex(
                name: "IX_Grad_DrzavaId",
                table: "Grad",
                column: "DrzavaId");

            migrationBuilder.CreateIndex(
                name: "IX_Karta_TerminId",
                table: "Karta",
                column: "TerminId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloge_KorisnikId",
                table: "KorisnikUloge",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloge_UlogaId",
                table: "KorisnikUloge",
                column: "UlogaId");

            migrationBuilder.CreateIndex(
                name: "IX_Kupovina_KartaId",
                table: "Kupovina",
                column: "KartaId");

            migrationBuilder.CreateIndex(
                name: "IX_Kupovina_KorisnikId",
                table: "Kupovina",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Obavijest_KorisnikId",
                table: "Obavijest",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Obavijest_ObavijestKategorijaId",
                table: "Obavijest",
                column: "ObavijestKategorijaId");

            migrationBuilder.CreateIndex(
                name: "IX_Pozoriste_GradId",
                table: "Pozoriste",
                column: "GradId");

            migrationBuilder.CreateIndex(
                name: "IX_PredstavaGlumac_GlumacId",
                table: "PredstavaGlumac",
                column: "GlumacId");

            migrationBuilder.CreateIndex(
                name: "IX_PredstavaGlumac_PredstavaId",
                table: "PredstavaGlumac",
                column: "PredstavaId");

            migrationBuilder.CreateIndex(
                name: "IX_PredstavaVrstaPredstave_PredstavaId",
                table: "PredstavaVrstaPredstave",
                column: "PredstavaId");

            migrationBuilder.CreateIndex(
                name: "IX_PredstavaVrstaPredstave_VrstaPredstaveId",
                table: "PredstavaVrstaPredstave",
                column: "VrstaPredstaveId");

            migrationBuilder.CreateIndex(
                name: "IX_Sala_PozoristeId",
                table: "Sala",
                column: "PozoristeId");

            migrationBuilder.CreateIndex(
                name: "IX_Termin_PredstavaId",
                table: "Termin",
                column: "PredstavaId");

            migrationBuilder.CreateIndex(
                name: "IX_Termin_SalaId",
                table: "Termin",
                column: "SalaId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "KorisnikUloge");

            migrationBuilder.DropTable(
                name: "Kupovina");

            migrationBuilder.DropTable(
                name: "Obavijest");

            migrationBuilder.DropTable(
                name: "PredstavaGlumac");

            migrationBuilder.DropTable(
                name: "PredstavaVrstaPredstave");

            migrationBuilder.DropTable(
                name: "Uloga");

            migrationBuilder.DropTable(
                name: "Karta");

            migrationBuilder.DropTable(
                name: "Korisnik");

            migrationBuilder.DropTable(
                name: "ObavijestKategorija");

            migrationBuilder.DropTable(
                name: "Glumac");

            migrationBuilder.DropTable(
                name: "VrstaPredstave");

            migrationBuilder.DropTable(
                name: "Termin");

            migrationBuilder.DropTable(
                name: "Predstava");

            migrationBuilder.DropTable(
                name: "Sala");

            migrationBuilder.DropTable(
                name: "Pozoriste");

            migrationBuilder.DropTable(
                name: "Grad");

            migrationBuilder.DropTable(
                name: "Drzava");
        }
    }
}
