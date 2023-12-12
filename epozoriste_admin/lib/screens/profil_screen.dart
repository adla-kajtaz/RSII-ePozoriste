import 'package:epozoriste_admin/models/korisnik.dart';
import 'package:epozoriste_admin/providers/auth_provider.dart';
import 'package:epozoriste_admin/providers/korisnik_provider.dart';
import 'package:epozoriste_admin/screens/login_screen.dart';
import 'package:epozoriste_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final formKey = GlobalKey<FormState>();
  AuthProvider? _authProvider;
  KorisnikProvider? _korisnikProvider;
  Korisnik? korisnik;
  bool updateFailed = false;

  @override
  void initState() {
    super.initState();
    _korisnikProvider = context.read<KorisnikProvider>();
    _authProvider = context.read<AuthProvider>();
    loadUser();
  }

  void loadUser() async {
    var data =
        await _korisnikProvider!.getUser(_authProvider!.getLoggedUserId());
    setState(() {
      korisnik = data;
    });
  }

  bool korisnickoImeValidno(String value) {
    RegExp regex = RegExp(r'^.{4,}$');
    return regex.hasMatch(value);
  }

  bool brTelefonaValidan(String value) {
    RegExp regex = RegExp(r'^\d{3}-\d{3}-(\d{4}|\d{3})$');
    return regex.hasMatch(value);
  }

  bool emailValidan(String value) {
    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
        caseSensitive: false);
    return regex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    if (korisnik == null) {
      return const Center(
        child: Text(
          'Učitavanje ...',
          style: TextStyle(
            color: Color.fromARGB(225, 195, 178, 178),
          ),
        ),
      );
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SizedBox(
                width: 600,
                child: Form(
                  key: formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          onSaved: (newValue) =>
                              korisnik!.korisnickoIme = newValue!,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Ovo polje je obavezno!";
                            }
                            if (!korisnickoImeValidno(value)) {
                              return 'Korisničko ime mora sadržavati namjanje 4 karaktera!';
                            }
                            if (updateFailed) {
                              return "Korisničko ime već postoji!";
                            }
                            return null;
                          },
                          initialValue: korisnik!.korisnickoIme,
                          decoration: const InputDecoration(
                            labelText: 'Korisničko ime',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          onSaved: (newValue) => korisnik!.email = newValue!,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Ovo polje je obavezno";
                            }
                            if (!emailValidan(value)) {
                              return 'Unesite validnu email adresu!';
                            }
                            return null;
                          },
                          initialValue: korisnik!.email,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Email',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          onSaved: (newValue) => korisnik!.ime = newValue!,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Ovo polje je obavezno";
                            }
                            return null;
                          },
                          initialValue: korisnik!.ime,
                          decoration: const InputDecoration(
                            labelText: 'Ime',
                            hintText: 'Ime',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          onSaved: (newValue) => korisnik!.prezime = newValue!,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Ovo polje je obavezno";
                            }
                            return null;
                          },
                          initialValue: korisnik!.email,
                          decoration: const InputDecoration(
                            labelText: 'Prezime',
                            hintText: 'Prezime',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          onSaved: (newValue) =>
                              korisnik!.brTelefona = newValue!,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Ovo polje je obavezno";
                            }
                            if (!brTelefonaValidan(value)) {
                              return 'Unesite broj telefona u formatu 06x-xxx-xxx!';
                            }
                            return null;
                          },
                          initialValue: korisnik!.brTelefona,
                          decoration: const InputDecoration(
                            labelText: 'Broj telefona',
                            hintText: 'Broj telefona',
                          ),
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () async {
                            updateFailed = false;
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              Map<String, dynamic> data = {
                                "ime": korisnik!.ime,
                                "prezime": korisnik!.prezime,
                                "korisnickoIme": korisnik!.korisnickoIme,
                                "email": korisnik!.email,
                                "brTelefona": korisnik!.brTelefona,
                              };
                              try {
                                await _korisnikProvider!
                                    .updateProfile(korisnik!.korisnikId, data);
                                if (context.mounted) {
                                  Authorization.username =
                                      korisnik!.korisnickoIme;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Profil je uspješno ažuriran!'),
                                    ),
                                  );
                                }
                              } on Exception catch (error) {
                                print(error.toString());
                                if (error.toString().contains("Bad request")) {
                                  updateFailed = true;
                                  formKey.currentState!.validate();
                                }
                              }
                            }
                          },
                          child: const Text('Sačuvaj promjene',
                              style: TextStyle(fontSize: 20)),
                        ),
                        const SizedBox(height: 35),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () async {
                            _authProvider!.logout();
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                          child: const Text('Logout',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
