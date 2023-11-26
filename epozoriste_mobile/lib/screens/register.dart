import 'package:epozoriste_mobile/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class Register extends StatefulWidget {
  static const routeName = '/register';

  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

bool isLozinkaValid(String value) {
  RegExp regex = RegExp(r'^.{8,}$');
  return regex.hasMatch(value);
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

class _RegisterState extends State<Register> {
  AuthProvider? _authProvider;
  final formKey = GlobalKey<FormState>();
  String? ime;
  String? prezime;
  String? korisnickoIme;
  String? email;
  String? brTelefona;
  String? lozinka;
  List<int> uloge = [2];
  List<String> errors = [];

  @override
  void initState() {
    super.initState();
    _authProvider = context.read<AuthProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 86, 81, 81),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  'ePozoriste',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(225, 195, 178, 178),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(children: [
                        Flexible(
                          child: TextFormField(
                            onSaved: (newValue) => ime = newValue,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Ovo polje je obavezno!";
                              }
                            },
                            style: const TextStyle(
                                color: Color.fromARGB(225, 195, 178, 178)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              labelText: 'Ime',
                              hintText: 'Ime',
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(225, 195, 178, 178)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: TextFormField(
                            onSaved: (newValue) => prezime = newValue,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Ovo polje je obavezno!";
                              }
                            },
                            style: const TextStyle(
                                color: Color.fromARGB(225, 195, 178, 178)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              labelText: 'Prezime',
                              hintText: 'Prezime',
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(225, 195, 178, 178)),
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 10),
                      TextFormField(
                        onSaved: (newValue) => email = newValue,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ovo polje je obavezno!";
                          }
                          if (!isEmailValid(value!)) {
                            return "Unesite validnu email adresu!";
                          }
                        },
                        style: const TextStyle(
                            color: Color.fromARGB(225, 195, 178, 178)),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          labelText: 'Email',
                          hintText: 'email@example.com',
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(225, 195, 178, 178)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        onSaved: (newValue) => brTelefona = newValue,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ovo polje je obavezno!";
                          }
                          if (!isPhoneNumberValid(value!)) {
                            return "Unesite broj telefona u formatu 06x-xxx-xxx!";
                          }
                        },
                        style: const TextStyle(
                            color: Color.fromARGB(225, 195, 178, 178)),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          labelText: 'Broj telefona',
                          hintText: '061-000-000',
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(225, 195, 178, 178)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        onSaved: (newValue) => korisnickoIme = newValue,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ovo polje je obavezno!";
                          }
                          if (!isKorisnickoImeValid(value!)) {
                            return "Ovo polje mora imati najmanje 4 karaktera!";
                          }
                          if (errors.isNotEmpty &&
                              errors.any((e) =>
                                  e ==
                                  "Postoji korisnik sa tim korisnickim imenom!")) {
                            return 'Korisničko ime već postoji!';
                          }
                        },
                        style: const TextStyle(
                            color: Color.fromARGB(225, 195, 178, 178)),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          labelText: 'Korisničko ime',
                          hintText: 'korisničko ime',
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(225, 195, 178, 178)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        onSaved: (newValue) => lozinka = newValue,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ovo polje je obavezno!";
                          }
                          if (!isLozinkaValid(value!)) {
                            return "Lozinka mora sadržavati 8 karaktera!";
                          }
                        },
                        obscureText: true,
                        autocorrect: false,
                        style: const TextStyle(
                            color: Color.fromARGB(225, 195, 178, 178)),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          labelText: 'Lozinka',
                          hintText: '********',
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(225, 195, 178, 178)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () async {
                          errors = [];
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          formKey.currentState!.save();
                          Map newUser = {
                            'ime': ime,
                            'prezime': prezime,
                            'korisnickoIme': korisnickoIme,
                            'email': email,
                            'brTelefona': brTelefona,
                            'aktivan': true,
                            'lozinka': lozinka,
                            'uloge': [2]
                          };
                          try {
                            print(newUser);

                            var data = await _authProvider!.register(newUser);
                            if (context.mounted) {
                              showMessage(
                                  "Uspješno ste se registrovali, prijavite se da bi ste pristupili aplikaciji!");
                            }
                          } on Exception catch (error) {
                            print(error.toString());
                            if (error.toString().contains("Bad request")) {
                              print(error.toString());
                              if (error.toString().contains(
                                  "Postoji korisnik sa tim korisnickim imenom!")) {
                                errors.add(
                                    "Postoji korisnik sa tim korisnickim imenom!");
                              }

                              formKey.currentState!.validate();
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
                              'Registruj se',
                              style: TextStyle(
                                  color: Color.fromARGB(225, 86, 81, 81),
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 5),
                    const Text(
                      'Vec imate račun? ',
                      style:
                          TextStyle(color: Color.fromARGB(225, 195, 178, 178)),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, Login.routeName),
                      child: const Text(
                        'Prijavi se ovdje',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showMessage(String message) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Uspješna registracija"),
              content: Text(message),
              actions: [
                TextButton(
                    child: const Text("Ok"),
                    onPressed: () =>
                        Navigator.popAndPushNamed(context, Login.routeName))
              ],
            ));
  }
}
