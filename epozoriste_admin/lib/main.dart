import 'package:epozoriste_admin/providers/karta_provider.dart';
import 'package:epozoriste_admin/providers/korisnik_provider.dart';
import 'package:epozoriste_admin/providers/predstava_glumac_provider.dart';
import 'package:epozoriste_admin/providers/termin_provider.dart';
import 'package:epozoriste_admin/providers/vrsta_predstave_provider.dart';
import 'package:epozoriste_admin/screens/karte_screen.dart';
import 'package:epozoriste_admin/screens/lista_glumaca_screen.dart';
import 'package:epozoriste_admin/screens/login_screen.dart';
import 'package:epozoriste_admin/screens/main_navigation_screen.dart';
import 'package:epozoriste_admin/screens/sale_screen.dart';
import 'package:epozoriste_admin/screens/termini_screen.dart';
import 'providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DrzavaProvider()),
        ChangeNotifierProvider(create: (_) => GradoviProvider()),
        ChangeNotifierProvider(create: (_) => GlumacProvider()),
        ChangeNotifierProvider(create: (_) => KategorijaObavijestProvider()),
        ChangeNotifierProvider(create: (_) => ObavijestProvider()),
        ChangeNotifierProvider(create: (_) => PozoristeProvider()),
        ChangeNotifierProvider(create: (_) => SaleProvider()),
        ChangeNotifierProvider(create: (_) => TerminProvider()),
        ChangeNotifierProvider(create: (_) => PredstavaProvider()),
        ChangeNotifierProvider(create: (_) => KartaProvider()),
        ChangeNotifierProvider(create: (_) => VrstaPredstaveProvider()),
        ChangeNotifierProvider(create: (_) => PredstavaGlumacProvider()),
        ChangeNotifierProvider(create: (_) => KorisnikProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ePozoriste Admin',
      theme: ThemeData(
        dataTableTheme: DataTableThemeData(
          headingRowColor:
              MaterialStateColor.resolveWith((states) => Colors.indigo),
          headingTextStyle: const TextStyle(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        MainNavigationScreen.routeName: (context) =>
            const MainNavigationScreen(),
        SaleScreen.routeName: (context) =>
            SaleScreen(id: ModalRoute.of(context)!.settings.arguments as int),
        TerminiScreen.routeName: (context) => TerminiScreen(
            salaId: ModalRoute.of(context)!.settings.arguments as int),
        KarteScreen.routeName: (context) => KarteScreen(
            terminId: ModalRoute.of(context)!.settings.arguments as int),
        ListaGlumacaScreen.routeName: (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return ListaGlumacaScreen(
            predstavaId: args['predstavaId'] as int,
            naziv: args['naziv'] as String,
          );
        },
      },
    );
  }
}
