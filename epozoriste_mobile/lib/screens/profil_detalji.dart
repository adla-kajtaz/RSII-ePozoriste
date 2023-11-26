import 'package:epozoriste_mobile/models/korisnik.dart';
import 'package:epozoriste_mobile/providers/korisnik_provider.dart';
import '../providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/util.dart';

class DetaljiProfila extends StatefulWidget {
  static const routeName = '/detaljiProfil';

  const DetaljiProfila({super.key});

  @override
  State<DetaljiProfila> createState() => _DetaljiProfilaState();
}

class _DetaljiProfilaState extends State<DetaljiProfila> {
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

  bool isKorisnickoImeValid(String value) {
    RegExp regex = RegExp(r'^.{4,}$');
    return regex.hasMatch(value);
  }

  bool isPhoneNumberValid(String value) {
    RegExp regex = RegExp(r'^\d{3}-\d{3}-(\d{4}|\d{3})$');
    return regex.hasMatch(value);
  }

  bool isEmailValid(String value) {
    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
        caseSensitive: false);
    return regex.hasMatch(value);
  }

  void closeToast(context, scaffold) async {
    scaffold.hideCurrentSnackBar;
    await Future.delayed(const Duration(milliseconds: 400));
    Navigator.pop(context);
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Profil je uspješno ažuriran!'),
        action: SnackBarAction(
            label: 'OK', onPressed: () => closeToast(context, scaffold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (korisnik == null) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 86, 81, 81),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 57, 53, 53),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Color.fromARGB(225, 195, 178, 178)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Profil',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: const Center(
          child: Text(
            'Učitavanje ...',
            style: TextStyle(
              color: Color.fromARGB(225, 195, 178, 178),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 86, 81, 81),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 57, 53, 53),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(225, 195, 178, 178)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Korisničko ime:',
                      style: TextStyle(
                        color: Color.fromARGB(225, 195, 178, 178),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      onSaved: (newValue) =>
                          korisnik!.korisnickoIme = newValue!,
                      initialValue: korisnik!.korisnickoIme,
                      style: const TextStyle(
                        color: Color.fromARGB(225, 195, 178, 178),
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(225, 195, 178, 178),
                        ),
                      ),
                      validator: (newValue) {
                        if (newValue!.isEmpty) {
                          return 'Ovo polje je obavezno!';
                        }
                        if (!isKorisnickoImeValid(newValue!)) {
                          return "Korisničko ime mora sadržavati najmanje 4 karaktera!";
                        }
                        if (updateFailed) {
                          return "Korisničko ime već postoji!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Email:',
                      style: TextStyle(
                        color: Color.fromARGB(225, 195, 178, 178),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      onSaved: (newValue) => korisnik!.email = newValue!,
                      initialValue: korisnik!.email,
                      style: const TextStyle(
                          color: Color.fromARGB(225, 195, 178, 178)),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(225, 195, 178, 178)),
                      ),
                      validator: (newValue) {
                        if (newValue!.isEmpty) {
                          return 'Ovo polje je obavezno!';
                        }
                        if (!isEmailValid(newValue!)) {
                          return "Unesite validnu email adresu!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Ime:',
                      style: TextStyle(
                        color: Color.fromARGB(225, 195, 178, 178),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      onSaved: (newValue) => korisnik!.ime = newValue!,
                      initialValue: korisnik!.ime,
                      style: const TextStyle(
                          color: Color.fromARGB(225, 195, 178, 178)),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(225, 195, 178, 178)),
                      ),
                      validator: (newValue) {
                        if (newValue!.isEmpty) {
                          return 'Ovo polje je obavezno!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Prezime:',
                      style: TextStyle(
                        color: Color.fromARGB(225, 195, 178, 178),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      onSaved: (newValue) => korisnik!.prezime = newValue!,
                      initialValue: korisnik!.prezime,
                      style: const TextStyle(
                          color: Color.fromARGB(225, 195, 178, 178)),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(225, 195, 178, 178)),
                      ),
                      validator: (newValue) {
                        if (newValue!.isEmpty) {
                          return 'Ovo polje je obavezno!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Broj telefona:',
                      style: TextStyle(
                        color: Color.fromARGB(225, 195, 178, 178),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      onSaved: (newValue) => korisnik!.brTelefona = newValue!,
                      initialValue: korisnik!.brTelefona,
                      style: const TextStyle(
                          color: Color.fromARGB(225, 195, 178, 178)),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(225, 195, 178, 178)),
                      ),
                      validator: (newValue) {
                        if (newValue!.isEmpty) {
                          return 'Ovo polje je obavezno!';
                        }
                        if (!isPhoneNumberValid(newValue!)) {
                          return "Unesite broj telefona u formatu 06x-xxx-xxx!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () async {
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
                          print(data);
                          try {
                            await _korisnikProvider!
                                .updateProfile(korisnik!.korisnikId, data);
                            if (context.mounted) {
                              Authorization.username = korisnik!.korisnickoIme;
                              _showToast(context);
                            }
                          } on Exception catch (err) {
                            print(err.toString());
                            if (err.toString().contains("Bad request")) {
                              updateFailed = true;
                              formKey.currentState!.validate();
                            }
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(225, 217, 217, 217),
                        ),
                        height: 50,
                        child: const Center(
                          child: Text(
                            'Sačuvaj promjene',
                            style: TextStyle(
                                color: Color.fromARGB(225, 86, 81, 81),
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
