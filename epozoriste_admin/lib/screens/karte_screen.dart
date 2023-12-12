import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/karta_provider.dart';
import 'package:epozoriste_admin/providers/termin_provider.dart';
import 'package:epozoriste_admin/widgets/pregled_karata.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KarteScreen extends StatefulWidget {
  static const routeName = '/karte';
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
  TerminProvider? _terminProvider;
  List<Karta> _karte = [];
  bool filterAktivan = false;

  @override
  void initState() {
    super.initState();
    _kartaProvider = context.read<KartaProvider>();
    _terminProvider = context.read<TerminProvider>();
    loadData();
  }

  void loadData() async {
    var data = await _kartaProvider!.get({
      'TerminId': widget.terminId,
      'Aktivan': filterAktivan ? true : null,
    });
    setState(() {
      _karte = data;
    });
  }

  void prikazSjedista() {
    int slobodne = _karte.where((k) => k.aktivna).toList().length;
    int kupljenje = _karte.where((k) => !k.aktivna).toList().length;
    int brojSjedista = _karte[0].termin!.sala!.brSjedista;
    int brojRedova = _karte[0].termin!.sala!.brRedova;
    int brojSjedistaPoRedu = _karte[0].termin!.sala!.brSjedistaPoRedu;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text("Pregled karata"),
            content: PregledKarata(
              brojSlobodnih: slobodne,
              brojZauzetih: kupljenje,
              brSjedista: brojSjedista,
              brojRedova: brojRedova,
              brojSjedistaPoRedu: brojSjedistaPoRedu,
              karte: _karte,
            ));
      },
    );
  }

  void openDeleteModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Brisanje'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da želite da obrišete karte?'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Poništi'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  var brisanje =
                      await _terminProvider!.obrisiKarte(widget.terminId);

                  if (brisanje && context.mounted) {
                    Navigator.pop(context);
                    loadData();
                  }
                } catch (e) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Ne možete obrisati karte jer su neke već kupljene!'),
                      ),
                    );
                  }
                }
              },
              child: const Text(
                'Obriši',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void createReport() async {
    int aktivne = _karte.where((k) => k.aktivna).toList().length;
    int neaktivne = _karte.where((k) => !k.aktivna).toList().length;
    int total = aktivne + neaktivne;
    String procentAktivne = "${(aktivne / total * 100).round()}%";
    String procentNeaktivne = "${(neaktivne / total * 100).round()}%";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Izvještaj'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        color: Colors.green,
                        value: aktivne.toDouble(),
                        title: procentAktivne,
                      ),
                      PieChartSectionData(
                        color: Colors.red,
                        value: neaktivne.toDouble(),
                        title: procentNeaktivne,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text('Slobodne karte ${aktivne.toString()}')
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text('Kupljene karte: ${neaktivne.toString()}')
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Prikaz karata')),
        body: SingleChildScrollView(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    loadData();
                  },
                  child: const Text('Prikaži'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    openDeleteModal();
                  },
                  child: const Text('Obriši'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    createReport();
                  },
                  child: const Text('Izvještaj'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    prikazSjedista();
                  },
                  child: const Text('Prikaz sjedišta'),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 0,
                columns: const [
                  DataColumn(label: Text('Broj sjedista')),
                  DataColumn(label: Text('Broj reda')),
                  DataColumn(label: Text('Sjedište')),
                  DataColumn(label: Text('Aktivna')),
                ],
                rows: _karte.isNotEmpty
                    ? _karte.map((karta) {
                        return DataRow(cells: [
                          DataCell(Text(karta.brojSjedista.toString())),
                          DataCell(Text(karta.brojReda)),
                          DataCell(Text(karta.sjediste)),
                          DataCell(
                            Checkbox(
                              value: karta.aktivna,
                              onChanged: (bool? s) {},
                              activeColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ]);
                      }).toList()
                    : [
                        const DataRow(cells: [
                          DataCell(Text('')),
                          DataCell(
                              Center(child: Text('Nema rezultata pretrage'))),
                          DataCell(Text('')),
                          DataCell(Text('')),
                        ])
                      ],
              ),
            )
          ]),
        ));
  }
}
