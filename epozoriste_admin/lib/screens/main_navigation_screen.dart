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
    NavigationItem(
        label: 'Drzave', widget: const Text('Drzave', style: optionStyle)),
    NavigationItem(
        label: 'Gradovi', widget: const Text('Gradovi', style: optionStyle)),
    // Add more items here in the same pattern
    NavigationItem(
        label: 'Glumci', widget: const Text('Glumci', style: optionStyle)),
    NavigationItem(
        label: 'Predstave',
        widget: const Text('Predstave', style: optionStyle)),
    NavigationItem(
        label: 'Vrste predstave',
        widget: const Text('Pozorista', style: optionStyle)),
    NavigationItem(
        label: 'Pozorista',
        widget: const Text('Pozorista', style: optionStyle)),
    NavigationItem(
        label: 'Obavijesti',
        widget: const Text('Obavijesti', style: optionStyle)),
    NavigationItem(
        label: 'Vrste obavijesti',
        widget: const Text('Vrste obavijesti', style: optionStyle)),
    NavigationItem(
        label: 'Zarada', widget: const Text('Zarada', style: optionStyle)),
    NavigationItem(
        label: 'Profil', widget: const Text('Profil', style: optionStyle)),
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
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
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
