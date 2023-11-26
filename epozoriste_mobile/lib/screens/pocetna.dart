import 'package:epozoriste_mobile/screens/preporuceni.dart';
import 'package:epozoriste_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/termin_provider.dart';

class Pocetna extends StatefulWidget {
  const Pocetna({super.key});
  @override
  State<Pocetna> createState() => _PocetnaState();
}

class _PocetnaState extends State<Pocetna> {
  List<Termin> termini = [];
  TerminProvider? _terminProvider;

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Trenutno se prikazuje'),
    const Tab(text: 'Preporučeno')
  ];

  @override
  void initState() {
    super.initState();
    _terminProvider = context.read<TerminProvider>();
    loadData();
  }

  Future loadData() async {
    var tempData = await _terminProvider?.get();

    setState(() {
      termini = tempData!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 86, 81, 81),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 57, 53, 53),
            title: const Text(
              'Predstave',
              style: TextStyle(color: Colors.white),
            ),
            bottom: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: const Color.fromARGB(225, 195, 178, 178),
                indicatorColor: Colors.white,
                tabs: myTabs),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: TabBarView(
              children: [
                ListaPredstava(termini: [...termini]),
                Preporuceni(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
