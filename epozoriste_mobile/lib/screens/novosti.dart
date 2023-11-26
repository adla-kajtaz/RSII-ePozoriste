import 'package:epozoriste_mobile/models/models.dart';
import 'package:epozoriste_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/obavijest_provider.dart';

class Novosti extends StatefulWidget {
  const Novosti({super.key});

  @override
  State<Novosti> createState() => _NovostiState();
}

class _NovostiState extends State<Novosti> {
  List<Obavijest> obavijesti = [];
  ObavijestProvider? _obavijestProvider;

  @override
  void initState() {
    super.initState();
    _obavijestProvider = context.read<ObavijestProvider>();
    loadData();
  }

  Future loadData() async {
    var tempData = await _obavijestProvider?.get();
    setState(() {
      obavijesti = tempData!;
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
              'Obavijesti',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListaNovosti(obavijesti: [...obavijesti]),
          ),
        ),
      ),
    );
  }
}
