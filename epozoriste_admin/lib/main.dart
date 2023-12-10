import 'package:epozoriste_admin/screens/login_screen.dart';
import 'package:epozoriste_admin/screens/main_navigation_screen.dart';
import 'package:epozoriste_admin/screens/sale_screen.dart';
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
      title: 'Flutter Demo',
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
      },
    );
  }
}
