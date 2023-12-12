import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/providers.dart';
import 'package:epozoriste_admin/providers/vrsta_predstave_provider.dart';
import 'package:epozoriste_admin/screens/lista_glumaca_screen.dart';
import 'package:epozoriste_admin/widgets/modals/predstava/add_glumac_predstava_modal.dart';
import 'package:epozoriste_admin/widgets/modals/predstava/add_predstava_modal.dart';
import 'package:epozoriste_admin/widgets/modals/predstava/edit_predstava_modal.dart';
import 'package:epozoriste_admin/widgets/predstava_zarada.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PredstaveScreen extends StatefulWidget {
  const PredstaveScreen({super.key});

  @override
  State<PredstaveScreen> createState() => _PredstaveScreenState();
}

class _PredstaveScreenState extends State<PredstaveScreen> {
  PredstavaProvider? _predstaveProvider;
  VrstaPredstaveProvider? _vrstaPredstaveProvider;
  List<Predstava>? _predstave;
  final TextEditingController _searchController = TextEditingController();
  List<VrstaPredstave> _vrstePredstave = [
    VrstaPredstave(vrstaPredstaveId: 0, naziv: 'Sve')
  ];
  VrstaPredstave? _selectedVrstaPredstave;
  @override
  void initState() {
    super.initState();
    _predstaveProvider = context.read<PredstavaProvider>();
    _vrstaPredstaveProvider = context.read<VrstaPredstaveProvider>();
    _selectedVrstaPredstave = _vrstePredstave[0];
    loadData();
    loadVrste();
  }

  void loadVrste() async {
    var data = await _vrstaPredstaveProvider!.get();
    setState(() {
      _vrstePredstave = [..._vrstePredstave, ...data];
    });
  }

  void loadData() async {
    dynamic request = {
      'VrstaPredstaveId': _selectedVrstaPredstave!.vrstaPredstaveId == 0
          ? null
          : _selectedVrstaPredstave?.vrstaPredstaveId,
      'Tekst': _searchController.text
    };
    var data = await _predstaveProvider!.get(request);
    setState(() {
      _predstave = data;
    });
  }

  void handleEdit(int id, dynamic request) async {
    await _predstaveProvider!.update(id, request);
    if (context.mounted) {
      Navigator.pop(context);
      loadData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text('Uspješno ste modifikovali podatke o predstavi!'),
        ),
      );
    }
  }

  void openEditModal(Predstava p) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditPredstavaModal(predstava: p, handleEdit: handleEdit);
      },
    );
  }

  void openDeleteModal(Predstava p) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Brisanje '),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da želite da obrišete predstavu?'),
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
                  await _predstaveProvider!.remove(p.predstavaId);
                  if (context.mounted) {
                    Navigator.pop(context);
                    loadData();
                  }
                } catch (e) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                            'Ne možete obrisati predstavu  jer postoji termin za nju!'),
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

  void handleAdd(dynamic request) async {
    var response = await _predstaveProvider!.insert(request);
    if (context.mounted) {
      Navigator.pop(context);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AddGlumacPredstavaModal(
            nazivPredstave: response!.naziv,
            predstavaId: response.predstavaId,
          );
        },
      );
      loadData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text('Uspješno ste dodali novu predstavu!'),
        ),
      );
    }
  }

  void openAddModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddPredstavaModal(handleAdd: handleAdd);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_predstave == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Predstava',
                      hintText: 'Unesite naziv predstave',
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: DropdownButtonFormField<VrstaPredstave>(
                    decoration: InputDecoration(
                      labelText: 'Vrsta predstave',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    value: _selectedVrstaPredstave,
                    onChanged: (VrstaPredstave? vp) {
                      setState(() {
                        _selectedVrstaPredstave = vp!;
                      });
                    },
                    items: _vrstePredstave
                        .map<DropdownMenuItem<VrstaPredstave>>(
                            (VrstaPredstave vp) {
                      return DropdownMenuItem<VrstaPredstave>(
                        value: vp,
                        child: Text(vp.naziv),
                      );
                    }).toList(),
                  ),
                ),
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
                  DataColumn(label: Text('Naziv')),
                  DataColumn(label: Text('Vrijeme trajanja')),
                  DataColumn(label: Text('Vrsta predstave')),
                  DataColumn(label: Text('Uredi')),
                  DataColumn(label: Text('Obriši')),
                  DataColumn(label: Text('Dodaj glumca')),
                  DataColumn(label: Text('Prikaz glumaca')),
                  DataColumn(label: Text('Izvjestaj')),
                ],
                rows: _predstave!.isNotEmpty
                    ? _predstave!.map((predstava) {
                        return DataRow(cells: [
                          DataCell(Text(predstava.naziv)),
                          DataCell(Text(predstava.vrijemeTrajanje.toString())),
                          DataCell(Text(predstava.vrstaPredstave!.naziv)),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.edit,
                                  color: Theme.of(context).primaryColor),
                              onPressed: () {
                                openEditModal(predstava);
                              },
                            ),
                          ),
                          DataCell(
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                openDeleteModal(predstava);
                              },
                            ),
                          ),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.person_add,
                                  color: Theme.of(context).primaryColor),
                              onPressed: () {
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddGlumacPredstavaModal(
                                      nazivPredstave: predstava.naziv,
                                      predstavaId: predstava.predstavaId,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.format_list_bulleted,
                                  color: Theme.of(context).primaryColor),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  ListaGlumacaScreen.routeName,
                                  arguments: {
                                    'predstavaId': predstava.predstavaId,
                                    'naziv': predstava.naziv
                                  },
                                );
                              },
                            ),
                          ),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.addchart,
                                  color: Theme.of(context).primaryColor),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Zarada po predstavi'),
                                      content: PredstavaZarada(
                                        predstavaId: predstava.predstavaId,
                                      ),
                                    );
                                  },
                                );
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
                          DataCell(
                              Center(child: Text('Nema rezultata pretrage'))),
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
