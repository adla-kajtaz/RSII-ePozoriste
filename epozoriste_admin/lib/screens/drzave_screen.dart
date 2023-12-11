import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/drzava_provider.dart';
import 'package:epozoriste_admin/widgets/modals/drzave/add_drzava_modal.dart';
import 'package:epozoriste_admin/widgets/modals/drzave/edit_drzava_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrzaveScreen extends StatefulWidget {
  const DrzaveScreen({Key? key}) : super(key: key);

  @override
  State<DrzaveScreen> createState() => _DrzaveScreenState();
}

class _DrzaveScreenState extends State<DrzaveScreen> {
  DrzavaProvider? _drzavaProvider;
  List<Drzava>? _drzave;
  final TextEditingController _searchController =
      TextEditingController(); // Add this line

  @override
  void initState() {
    super.initState();
    _drzavaProvider = context.read<DrzavaProvider>();
    loadData();
  }

  void loadData() async {
    var data = await _drzavaProvider!
        .get({'Tekst': _searchController.text}); // Modify this line
    setState(() {
      _drzave = data;
    });
  }

  void handleEdit(int id, String naziv, String skracenica) async {
    await _drzavaProvider!.update(id, {
      'naziv': naziv,
      'skracenica': skracenica,
    });
    if (context.mounted) {
      Navigator.pop(context);
      loadData();
    }
  }

  void openEditModal(Drzava drzava) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditDrzavaModal(
          drzava: drzava,
          handleEdit: handleEdit,
        );
      },
    );
  }

  void openDeleteModal(Drzava drzava) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Brisanje '),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da zelite da obrisete drzavu?'),
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
                  await _drzavaProvider!.remove(drzava.drzavaId);
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
                            'Ne možete obrisati drzavu jer postoji grad koji se veže na nju!'),
                      ),
                    );
                  }
                }
              },
              child: const Text(
                'Obrisi',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void handleAdd(String naziv, String skracenica) async {
    await _drzavaProvider!.insert({
      'naziv': naziv,
      'skracenica': skracenica,
    });
    if (context.mounted) {
      Navigator.pop(context);
      loadData();
    }
  }

  void openAddModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddDrzavaModal(handleAdd: handleAdd);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_drzave == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 16.0),
              Expanded(
                child: TextFormField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Drzava',
                    hintText: 'Unesite naziv drzave',
                  ),
                ),
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
            height: 300,
            width: double.infinity, // Set the width to take 100% of the screen
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Naziv')),
                  DataColumn(label: Text('Skracenica')),
                  DataColumn(label: Text('Uredi')),
                  DataColumn(label: Text('Obrisi')),
                ],
                rows: _drzave!.isNotEmpty
                    ? _drzave!.map((drzava) {
                        return DataRow(cells: [
                          DataCell(Text(drzava.naziv)),
                          DataCell(Text(drzava.skracenica)),
                          DataCell(IconButton(
                            icon: Icon(Icons.edit,
                                color: Theme.of(context).primaryColor),
                            onPressed: () {
                              openEditModal(drzava);
                            },
                          )),
                          DataCell(IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              openDeleteModal(drzava);
                            },
                          )),
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
            ),
          ),
        ],
      ),
    );
  }
}
