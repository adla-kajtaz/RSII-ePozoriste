import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/providers.dart';
import 'package:epozoriste_admin/providers/termin_provider.dart';
import 'package:epozoriste_admin/utils/util.dart';
import 'package:epozoriste_admin/widgets/modals/termini/add_termin_modal.dart';
import 'package:epozoriste_admin/widgets/modals/termini/edit_termin_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TerminiScreen extends StatefulWidget {
  final int salaId;
  static const routeName = "/termini";
  const TerminiScreen({super.key, required this.salaId});

  @override
  State<TerminiScreen> createState() => _TerminiScreenState();
}

class _TerminiScreenState extends State<TerminiScreen> {
  TerminProvider? _terminProvider;
  PredstavaProvider? _predstavaProvider;
  List<Termin>? _pozorista;
  DateTime? _selectedDate;
  bool filterPremiera = false;
  bool filterPredPremiera = false;
  List<Predstava> _predstave = [
    Predstava(
      predstavaId: 0,
      naziv: 'Sve',
      kostimografija: '',
      rezija: '',
      sadrzaj: '',
      scenografija: '',
      vrijemeTrajanje: 30,
      vrstaPredstaveId: 1,
      slika: '',
    )
  ];
  Predstava? _selectedPredstava;
  @override
  void initState() {
    super.initState();
    _terminProvider = context.read<TerminProvider>();
    _predstavaProvider = context.read<PredstavaProvider>();
    _selectedPredstava = _predstave[0];
    loadData();
    loadPredstave();
  }

  void resetState() {
    setState(() {
      _selectedDate = null;
      filterPremiera = false;
      filterPredPremiera = false;
    });
    loadData();
  }

  Future<void> handleSelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void loadPredstave() async {
    var data = await _predstavaProvider!.get(); // Modify this line
    setState(() {
      _predstave = [..._predstave, ...data];
    });
  }

  void loadData() async {
    dynamic request = {
      'SalaId': widget.salaId,
      'DatumOdrzavanja': _selectedDate?.toIso8601String(),
      'Premijera': filterPremiera ? true : null,
      'Predpremijera': filterPredPremiera ? true : null,
      'PredstavaId': _selectedPredstava!.predstavaId == 0
          ? null
          : _selectedPredstava!.predstavaId
    };
    var data = await _terminProvider!.get(request); // Modify this line
    setState(() {
      _pozorista = data;
    });
  }

  void handleEdit(int id, dynamic request) async {
    await _terminProvider!.update(id, request);
    if (context.mounted) {
      Navigator.pop(context);
      loadData();
    }
  }

  void openEditModal(Termin t) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditTerminModal(termin: t, handleEdit: loadData);
      },
    );
  }

  void openDeleteModal(Termin t) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Brisanje '),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da zelite da obrisete termin?'),
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
                  await _terminProvider!.remove(t.terminId);
                  if (context.mounted) {
                    Navigator.pop(context);
                    loadData();
                  }
                } catch (e) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Ne možete obrisati termin jer se koristi  !'),
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

  void openAddModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTerminModal(
          salaId: widget.salaId,
          handleAdd: loadData,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_pozorista == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Pregled termina')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Vertically align children in the center

              children: [
                const SizedBox(width: 16.0),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => handleSelectDate(context),
                      child: Text(
                        formatDateTime(_selectedDate ?? DateTime.now()),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                )),
                const SizedBox(width: 16.0, height: 16),
                Checkbox(
                  value: filterPremiera,
                  onChanged: (bool? s) {
                    setState(() {
                      filterPremiera = s!;
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),
                const Text('Premijera'),
                const SizedBox(width: 16),
                Checkbox(
                  value: filterPredPremiera,
                  onChanged: (bool? s) {
                    setState(() {
                      filterPredPremiera = s!;
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),
                const Text('Predpremijera'),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<Predstava>(
                    decoration: InputDecoration(
                      labelText: 'Predstava',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    value: _selectedPredstava,
                    onChanged: (Predstava? p) {
                      setState(() {
                        _selectedPredstava = p!;
                      });
                    },
                    items: _predstave
                        .map<DropdownMenuItem<Predstava>>((Predstava p) {
                      return DropdownMenuItem<Predstava>(
                        value: p,
                        child: Text(p.naziv),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 16.0, height: 16),
                ElevatedButton(
                  onPressed: () {
                    resetState();
                  },
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    loadData();
                  },
                  child: const Text('Pretraži'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    openAddModal();
                  },
                  child: const Text('+'),
                ),
                const SizedBox(width: 16.0),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 0,
                columns: const [
                  DataColumn(label: Text('Predstava')),
                  DataColumn(label: Text('Sala')),
                  DataColumn(label: Text('Datum izvodjenja')),
                  DataColumn(label: Text('Vrijeme odrzavanja')),
                  DataColumn(label: Text('Cijena karte')),
                  DataColumn(label: Text('Premijera')),
                  DataColumn(label: Text('Pretpremijera')),
                  DataColumn(label: Text('Karte')),
                  DataColumn(label: Text('Uredi')),
                  DataColumn(label: Text('Obriši')),
                ],
                rows: _pozorista!.isNotEmpty
                    ? _pozorista!.map((termin) {
                        return DataRow(cells: [
                          DataCell(
                            Tooltip(
                              message: termin.predstava!.naziv,
                              child: Text(
                                termin.predstava!.naziv.length > 20
                                    ? "${termin.predstava!.naziv.substring(0, 20)} ..."
                                    : termin.predstava!.naziv,
                              ),
                            ),
                          ),
                          DataCell(
                            Tooltip(
                              message: termin.sala!.naziv,
                              child: Text(
                                termin.sala!.naziv.length > 20
                                    ? "${termin.sala!.naziv.substring(0, 20)} ..."
                                    : termin.sala!.naziv,
                              ),
                            ),
                          ),
                          DataCell(Text(termin.datumOdrzavanja
                              .toString()
                              .substring(0, 10))),
                          DataCell(Text(termin.vrijemeOdrzavanja)),
                          DataCell(Text(termin.cijenaKarte.toString())),
                          DataCell(
                            Checkbox(
                              value: termin.premijera,
                              onChanged: (bool? s) {},
                              activeColor: Theme.of(context).primaryColor,
                            ),
                          ),
                          DataCell(
                            Checkbox(
                              value: termin.predpremijera,
                              onChanged: (bool? s) {},
                              activeColor: Theme.of(context).primaryColor,
                            ),
                          ),
                          DataCell(IconButton(
                            icon: Icon(Icons.apps_sharp,
                                color: Theme.of(context).primaryColor),
                            onPressed: () {
                              // Navigator.pushNamed(context, SaleScreen.routeName,
                              //     arguments: pozoriste.pozoristeId);
                            },
                          )),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.edit,
                                  color: Theme.of(context).primaryColor),
                              onPressed: () {
                                openEditModal(termin);
                              },
                            ),
                          ),
                          DataCell(
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                openDeleteModal(termin);
                              },
                            ),
                          ),
                        ]);
                      }).toList()
                    : [
                        const DataRow(cells: [
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(
                              Center(child: Text('Nema rezultata pretrage'))),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                        ])
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
