import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/karta_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KarteScreen extends StatefulWidget {
  final int terminId;
  const KarteScreen({
    super.key,
    required this.terminId,
  });

  @override
  State<KarteScreen> createState() => _KarteScreenState();
}

class _KarteScreenState extends State<KarteScreen> {
  KartaProvider? _kartaProvider;
  List<Karta>? _karte;
  bool filterAktivan = false;

  @override
  void initState() {
    super.initState();
    _kartaProvider = context.read<KartaProvider>();
    loadData();
  }

  void loadData() {
    _kartaProvider!.get({
      'TerminId': widget.terminId,
    }).then((value) {
      setState(() {
        _karte = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Prikaz karata')),
        body: SingleChildScrollView(
          child: Column(children: [
            Row(
              children: [
                Checkbox(
                  value: filterAktivan,
                  onChanged: (bool? s) {
                    setState(() {
                      filterAktivan = s!;
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),
                const Text('Aktivna'),
                ElevatedButton(
                  onPressed: () {
                    loadData();
                  },
                  child: const Text('Prikaži'),
                ),
                ElevatedButton(
                  onPressed: () {
                    loadData();
                  },
                  child: const Text('Obriši'),
                ),
                ElevatedButton(
                  onPressed: () {
                    loadData();
                  },
                  child: const Text('Izvještaj'),
                ),
                ElevatedButton(
                  onPressed: () {
                    loadData();
                  },
                  child: const Text('Prikaz sjedišta'),
                ),
              ],
            ),
          ]),
        ));
  }
}
