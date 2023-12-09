import 'package:epozoriste_admin/screens/login_screen.dart';
import 'package:epozoriste_admin/screens/main_navigation_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        MainNavigationScreen.routeName: (context) =>
            const MainNavigationScreen(),
      },
      home: const LoginScreen(),
    );
  }
}
