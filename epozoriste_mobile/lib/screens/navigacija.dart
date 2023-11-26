import 'package:flutter/material.dart';
import 'screens.dart';

class Navigacija extends StatefulWidget {
  static const routeName = '/home';

  const Navigacija({super.key});

  @override
  State<Navigacija> createState() => _NavigacijaState();
}

class _NavigacijaState extends State<Navigacija> {
  final List<Widget> _screens = [
    const Pocetna(),
    const Novosti(),
    const Profil()
  ];
  final List<IconData> _icons = const [
    Icons.home,
    Icons.newspaper,
    Icons.account_circle
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _icons.map((IconData icon) {
          return BottomNavigationBarItem(
            icon: Icon(icon, size: 30),
            label: '', // Add labels if needed
          );
        }).toList(),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(225, 195, 178, 178),
        backgroundColor: const Color.fromARGB(255, 57, 53, 53),
      ),
    );
  }
}
