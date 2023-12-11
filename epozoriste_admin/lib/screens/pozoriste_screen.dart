import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/gradovi_provider.dart';
import 'package:epozoriste_admin/providers/pozoriste_provider.dart';
import 'package:epozoriste_admin/screens/sale_screen.dart';
import 'package:epozoriste_admin/utils/util.dart';
import 'package:epozoriste_admin/widgets/modals/pozorista/add_pozoriste_modal.dart';
import 'package:epozoriste_admin/widgets/modals/pozorista/edit_pozoriste_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PozoristeScreen extends StatefulWidget {
  const PozoristeScreen({super.key});

  @override
  State<PozoristeScreen> createState() => _PozoristeScreenState();
}

class _PozoristeScreenState extends State<PozoristeScreen> {
  PozoristeProvider? _pozoristeProvider;
  GradoviProvider? _gradoviProvider;
  List<Pozoriste>? _pozorista;
  final TextEditingController _searchController =
      TextEditingController(); // Add this line
  List<Grad> _gradovi = [Grad(gradId: 0, naziv: 'Sve', postanskiBr: '0')];
  Grad? _selectedGrad;
  @override
  void initState() {
    super.initState();
    _pozoristeProvider = context.read<PozoristeProvider>();
    _gradoviProvider = context.read<GradoviProvider>();
    _selectedGrad = _gradovi[0];
    loadData();
    loadGradovi();
  }

  void loadGradovi() async {
    var data = await _gradoviProvider!.get(); // Modify this line
    setState(() {
      _gradovi = [..._gradovi, ...data];
    });
  }

  void loadData() async {
    dynamic request = {
      'GradId': _selectedGrad!.gradId == 0 ? null : _selectedGrad!.gradId,
      'Tekst': _searchController.text
    };
    var data = await _pozoristeProvider!.get(request); // Modify this line
    setState(() {
      _pozorista = data;
    });
  }

  void handleEdit(int id, dynamic request) async {
    await _pozoristeProvider!.update(id, request);
    if (context.mounted) {
      Navigator.pop(context);
      loadData();
    }
  }

  void openEditModal(Pozoriste p) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditPozoristeModal(pozoriste: p, handleEdit: handleEdit);
      },
    );
  }

  void openDeleteModal(Pozoriste p) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Brisanje '),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da zelite da obrisete pozoriste?'),
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
                  await _pozoristeProvider!.remove(p.pozoristeId);
                  if (context.mounted) {
                    Navigator.pop(context);
                    loadData();
                  }
                } catch (e) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Ne možete obrisati pozoriste jer se koristi!'),
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
    await _pozoristeProvider!.insert(request);
    print('prosao request');
    if (context.mounted) {
      Navigator.pop(context);
      loadData();
    }
  }

  void openAddModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddPozoristeModal(handleAdd: handleAdd);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_pozorista == null) {
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
                      labelText: 'Pozoriste',
                      hintText: 'Unesite naziv pozorista',
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: DropdownButtonFormField<Grad>(
                    decoration: InputDecoration(
                      labelText: 'Grad',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    value: _selectedGrad,
                    onChanged: (Grad? g) {
                      setState(() {
                        _selectedGrad = g!;
                      });
                    },
                    items: _gradovi.map<DropdownMenuItem<Grad>>((Grad g) {
                      return DropdownMenuItem<Grad>(
                        value: g,
                        child: Text(g.naziv),
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
                  DataColumn(label: Text('Adresa')),
                  DataColumn(label: Text('Grad')),
                  DataColumn(label: Text('Web stranica')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Broj telefona')),
                  DataColumn(label: Text('Aktivan')),
                  DataColumn(label: Text('Uredi')),
                  DataColumn(label: Text('Obrisi')),
                  DataColumn(label: Text('Sale')),
                ],
                rows: _pozorista!.isNotEmpty
                    ? _pozorista!.map((pozoriste) {
                        return DataRow(cells: [
                          DataCell(
                            Tooltip(
                              message: pozoriste.naziv,
                              child: Text(
                                pozoriste.naziv.length > 20
                                    ? "${pozoriste.naziv.substring(0, 20)} ..."
                                    : pozoriste.naziv,
                              ),
                            ),
                          ),
                          DataCell(
                            Tooltip(
                              message: pozoriste.adresa,
                              child: Text(
                                pozoriste.adresa.length > 20
                                    ? "${pozoriste.adresa.substring(0, 20)} ..."
                                    : pozoriste.adresa,
                              ),
                            ),
                          ),
                          DataCell(Text(pozoriste.grad!.naziv)),
                          DataCell(
                            Tooltip(
                              message: pozoriste.webstranica,
                              child: Text(
                                pozoriste.webstranica.length > 20
                                    ? "${pozoriste.webstranica.substring(0, 20)} ..."
                                    : pozoriste.webstranica,
                              ),
                            ),
                          ),
                          DataCell(Text(pozoriste.email)),
                          DataCell(Text(pozoriste.brTelefona)),
                          DataCell(
                            Checkbox(
                              value: pozoriste.aktivan,
                              onChanged: (bool? s) {},
                              activeColor: Theme.of(context).primaryColor,
                            ),
                          ),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.edit,
                                  color: Theme.of(context).primaryColor),
                              onPressed: () {
                                openEditModal(pozoriste);
                              },
                            ),
                          ),
                          DataCell(
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                openDeleteModal(pozoriste);
                              },
                            ),
                          ),
                          DataCell(IconButton(
                            icon: Icon(Icons.theater_comedy,
                                color: Theme.of(context).primaryColor),
                            onPressed: () {
                              Navigator.pushNamed(context, SaleScreen.routeName,
                                  arguments: pozoriste.pozoristeId);
                            },
                          )),
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
