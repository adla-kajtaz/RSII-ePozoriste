# RSII-ePozoriste

Seminarski rad iz predmeta Razvoj softvera II

ePozoriste je aplikacija za online kupovinu karata za pozoriste. Aplikacija se stastoji od desktop dijela koje je namijenjen za administratore, te mobilnog dijela koji je namijenjen krajnjim korisnicima. Desktop dio sluzi za upravljanje predstavama, terminima, kao i za izvjestavanje, dok na mobilnom dijelu krajnji korisnici mogu pregledati trenutno aktivne predstave, kupiti karte, i online placati.

### Kredencijali

Desktop aplikacija:

- korisnickoIme: admin
- lozinka: Test123!

Mobilna aplikacija:

- korisnickoIme: adlaKaj
- lozinka: Test123!

Testni podaci za Stripe:

- Broj kartice: 4242 4242 4242 4242
- Datum: Mozete ukucati bilo koji u buducnosti
- CVC: Mozete ukucati bilo koja 3 broja

## Pokretanje aplikacija

1. Nakon kloniranja repozitorija otvoriti komandnu liniju, navigirati do foldera gdje je kloniran repozitorij te pokrenuti dockerizovani API i bazu komandom:
   `docker-compose up --build`

2. Mobilna aplikacija se pokrece otvaranjem foldera epozoriste_mobile u VSCode-u, te se pokrenu sljedece komande u terminalu:

`flutter pub get` - za dobavljanje dependencies
`flutter run` - za pokretanje aplikacije

3. Desktop aplikacija se pokrece otvaranjem foldera epozoriste_admin u VSCode-u, te se pokrenu sljedece komande u terminalu:

`flutter pub get` - za dobavljanje dependencies
`flutter run` - za pokretanje aplikacije
