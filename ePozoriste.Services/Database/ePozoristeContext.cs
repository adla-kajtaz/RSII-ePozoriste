using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace ePozoriste.Services.Database
{
    public partial class ePozoristeContext : DbContext
    {
        public ePozoristeContext()
        {
        }

        public ePozoristeContext(DbContextOptions<ePozoristeContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Drzava> Drzavas { get; set; } = null!;
        public virtual DbSet<Glumac> Glumacs { get; set; } = null!;
        public virtual DbSet<Grad> Grads { get; set; } = null!;
        public virtual DbSet<Kartum> Karta { get; set; } = null!;
        public virtual DbSet<Korisnik> Korisniks { get; set; } = null!;
        public virtual DbSet<KorisnikUloge> KorisnikUloges { get; set; } = null!;
        public virtual DbSet<Kupovina> Kupovinas { get; set; } = null!;
        public virtual DbSet<Obavijest> Obavijests { get; set; } = null!;
        public virtual DbSet<ObavijestKategorija> ObavijestKategorijas { get; set; } = null!;
        public virtual DbSet<Pozoriste> Pozoristes { get; set; } = null!;
        public virtual DbSet<Predstava> Predstavas { get; set; } = null!;
        public virtual DbSet<PredstavaGlumac> PredstavaGlumacs { get; set; } = null!;
        public virtual DbSet<Sala> Salas { get; set; } = null!;
        public virtual DbSet<Termin> Termins { get; set; } = null!;
        public virtual DbSet<Uloga> Ulogas { get; set; } = null!;
        public virtual DbSet<VrstaPredstave> VrstaPredstaves { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=DESKTOP-2PVVE49\\MSSQLSERVER_OLAP;Database=ePozoriste;Trusted_Connection=True; TrustServerCertificate=true;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Drzava>(entity =>
            {
                entity.ToTable("Drzava");
            });

            modelBuilder.Entity<Glumac>(entity =>
            {
                entity.ToTable("Glumac");
            });

            modelBuilder.Entity<Grad>(entity =>
            {
                entity.ToTable("Grad");

                entity.HasOne(d => d.Drzava)
                    .WithMany(p => p.Grads)
                    .HasForeignKey(d => d.DrzavaId)
                    .HasConstraintName("FK__Grad__DrzavaId__2E1BDC42");
            });

            modelBuilder.Entity<Kartum>(entity =>
            {
                entity.HasKey(e => e.KartaId)
                    .HasName("PK__Karta__EC3FA9EE23583A11");

                entity.Property(e => e.Sjediste).IsUnicode(false);

                entity.HasOne(d => d.Termin)
                    .WithMany(p => p.Karta)
                    .HasForeignKey(d => d.TerminId)
                    .HasConstraintName("FK__Karta__TerminId__4D94879B");
            });

            modelBuilder.Entity<Korisnik>(entity =>
            {
                entity.ToTable("Korisnik");
            });

            modelBuilder.Entity<KorisnikUloge>(entity =>
            {
                entity.ToTable("KorisnikUloge");

                entity.HasOne(d => d.Korisnik)
                    .WithMany(p => p.KorisnikUloges)
                    .HasForeignKey(d => d.KorisnikId)
                    .HasConstraintName("FK__KorisnikU__Koris__29572725");

                entity.HasOne(d => d.Uloga)
                    .WithMany(p => p.KorisnikUloges)
                    .HasForeignKey(d => d.UlogaId)
                    .HasConstraintName("FK__KorisnikU__Uloga__286302EC");
            });

            modelBuilder.Entity<Kupovina>(entity =>
            {
                entity.ToTable("Kupovina");

                entity.Property(e => e.DatumKupovine).HasColumnType("datetime");

                entity.HasOne(d => d.Korisnik)
                    .WithMany(p => p.Kupovinas)
                    .HasForeignKey(d => d.KorisnikId)
                    .HasConstraintName("FK__Kupovina__Korisn__5070F446");
            });

            modelBuilder.Entity<Obavijest>(entity =>
            {
                entity.ToTable("Obavijest");

                entity.Property(e => e.DatumKreiranja).HasColumnType("datetime");

                entity.HasOne(d => d.Korisnik)
                    .WithMany(p => p.Obavijests)
                    .HasForeignKey(d => d.KorisnikId)
                    .HasConstraintName("FK__Obavijest__Koris__33D4B598");

                entity.HasOne(d => d.ObavijestKategorija)
                    .WithMany(p => p.Obavijests)
                    .HasForeignKey(d => d.ObavijestKategorijaId)
                    .HasConstraintName("FK__Obavijest__Obavi__32E0915F");
            });

            modelBuilder.Entity<ObavijestKategorija>(entity =>
            {
                entity.ToTable("ObavijestKategorija");
            });

            modelBuilder.Entity<Pozoriste>(entity =>
            {
                entity.ToTable("Pozoriste");

                entity.HasOne(d => d.Grad)
                    .WithMany(p => p.Pozoristes)
                    .HasForeignKey(d => d.GradId)
                    .HasConstraintName("FK__Pozoriste__GradI__36B12243");
            });

            modelBuilder.Entity<Predstava>(entity =>
            {
                entity.ToTable("Predstava");
            });

            modelBuilder.Entity<PredstavaGlumac>(entity =>
            {
                entity.ToTable("PredstavaGlumac");

                entity.HasOne(d => d.Glumac)
                    .WithMany(p => p.PredstavaGlumacs)
                    .HasForeignKey(d => d.GlumacId)
                    .HasConstraintName("FK__Predstava__Gluma__45F365D3");

                entity.HasOne(d => d.Predstava)
                    .WithMany(p => p.PredstavaGlumacs)
                    .HasForeignKey(d => d.PredstavaId)
                    .HasConstraintName("FK__Predstava__Preds__46E78A0C");
            });

            modelBuilder.Entity<Sala>(entity =>
            {
                entity.ToTable("Sala");

                entity.HasOne(d => d.Pozoriste)
                    .WithMany(p => p.Salas)
                    .HasForeignKey(d => d.PozoristeId)
                    .HasConstraintName("FK__Sala__PozoristeI__398D8EEE");
            });

            modelBuilder.Entity<Termin>(entity =>
            {
                entity.ToTable("Termin");

                entity.Property(e => e.DatumOdrzavanja).HasColumnType("datetime");

                entity.HasOne(d => d.Predstava)
                    .WithMany(p => p.Termins)
                    .HasForeignKey(d => d.PredstavaId)
                    .HasConstraintName("FK__Termin__Predstav__4316F928");

                entity.HasOne(d => d.Sala)
                    .WithMany(p => p.Termins)
                    .HasForeignKey(d => d.SalaId)
                    .HasConstraintName("FK__Termin__SalaId__4222D4EF");
            });

            modelBuilder.Entity<Uloga>(entity =>
            {
                entity.ToTable("Uloga");
            });

            modelBuilder.Entity<VrstaPredstave>(entity =>
            {
                entity.ToTable("VrstaPredstave");
            });

            OnModelCreatingPartial(modelBuilder);
            base.OnModelCreating(modelBuilder);
        }
        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
