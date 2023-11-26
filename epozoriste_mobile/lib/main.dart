import 'package:epozoriste_mobile/providers/auth_provider.dart';
import 'package:epozoriste_mobile/providers/karta_provider.dart';
import 'package:epozoriste_mobile/providers/korisnik_provider.dart';
import 'package:epozoriste_mobile/providers/kupovina_provider.dart';
import 'package:epozoriste_mobile/providers/obavijest_provider.dart';
import 'package:epozoriste_mobile/providers/termin_provider.dart';
import 'package:epozoriste_mobile/screens/preporuceni.dart';
import 'package:epozoriste_mobile/screens/screens.dart';
import 'package:epozoriste_mobile/screens/sjedista.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51NtWjdEDYm8POibPT31r3QwFT9jr7oT1eT5yHSjnxyTGdtLs1FNm9ytNJwylIdvHRaJBOFL97AkkR53eeYPSHCDE00nrXcw0rp";
  Stripe.merchantIdentifier = 'any string works';
  Stripe.urlScheme = "flutterstripe";
  await Stripe.instance.applySettings();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TerminProvider()),
        ChangeNotifierProvider(create: (_) => ObavijestProvider()),
        ChangeNotifierProvider(create: (_) => KorisnikProvider()),
        ChangeNotifierProvider(create: (_) => KartaProvider()),
        ChangeNotifierProvider(create: (_) => KupovinaProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ePozoriste',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 135, 127, 127)),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 160, 174, 184)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        Login.routeName: (context) => const Login(),
        Register.routeName: (context) => const Register(),
        Navigacija.routeName: (context) => const Navigacija(),
        DetaljiPredstave.routeName: (context) => const DetaljiPredstave(),
        DetaljiNovosti.routeName: (context) => const DetaljiNovosti(),
        DetaljiProfila.routeName: (context) => const DetaljiProfila(),
        Sjedista.routeName: (context) => const Sjedista(),
        UspjesnaKupovina.routeName: (context) => const UspjesnaKupovina(),
        Preporuceni.routeName: (context) => const Preporuceni(),
      },
    );
  }
}
