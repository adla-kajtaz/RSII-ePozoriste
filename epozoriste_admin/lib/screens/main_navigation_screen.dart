import 'package:epozoriste_admin/screens/drzave_screen.dart';
import 'package:epozoriste_admin/screens/glumci_screen.dart';
import 'package:epozoriste_admin/screens/gradovi_screen.dart';
import 'package:epozoriste_admin/screens/kategorije_obavijesti_screen.dart';
import 'package:epozoriste_admin/screens/obavijest_screen.dart';
import 'package:epozoriste_admin/screens/pozoriste_screen.dart';
import 'package:epozoriste_admin/screens/predstave_screen.dart';
import 'package:epozoriste_admin/screens/profil_screen.dart';
import 'package:epozoriste_admin/screens/vrste_predstave_screen.dart';
import 'package:epozoriste_admin/screens/zarada_screen.dart';
import 'package:flutter/material.dart';

class NavigationItem {
  final String label;
  final Widget widget;

  NavigationItem({required this.label, required this.widget});
}

class MainNavigationScreen extends StatefulWidget {
  static const routeName = "/home";
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<NavigationItem> _navigationItems = [
    NavigationItem(label: 'Drzave', widget: const DrzaveScreen()),
    NavigationItem(label: 'Gradovi', widget: const GradoviScreen()),
    NavigationItem(label: 'Glumci', widget: const GlumciScreen()),
    NavigationItem(label: 'Predstave', widget: const PredstaveScreen()),
    NavigationItem(
        label: 'Vrste predstave', widget: const VrstePredstaveScreen()),
    NavigationItem(label: 'Pozorista', widget: const PozoristeScreen()),
    NavigationItem(label: 'Obavijesti', widget: const ObavijestiScreen()),
    NavigationItem(
        label: 'Kategorije obavijesti',
        widget: const KategorijeObavijestiScreen()),
    NavigationItem(label: 'Zarada', widget: const ZaradaScreen()),
    NavigationItem(label: 'Profil', widget: const ProfilScreen()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_navigationItems[_selectedIndex].label)),
      body: Center(
        child: _navigationItems[_selectedIndex].widget,
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: _navigationItems.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_navigationItems[index].label),
              selected: _selectedIndex == index,
              onTap: () {
                _onItemTapped(index);
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
    );
  }
}
