import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/glumci_provider.dart';
import 'package:epozoriste_admin/widgets/modals/glumci/add_glumac_modal.dart';
import 'package:epozoriste_admin/widgets/modals/glumci/edit_glumac_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GlumciScreen extends StatefulWidget {
  const GlumciScreen({super.key});

  @override
  State<GlumciScreen> createState() => _GlumciScreenState();
}

class _GlumciScreenState extends State<GlumciScreen> {
  GlumacProvider? _glumacProvider;
  List<Glumac>? _glumci;
  final TextEditingController _searchController =
      TextEditingController(); // Add this line

  @override
  void initState() {
    super.initState();
    _glumacProvider = context.read<GlumacProvider>();
    loadData();
  }

  void loadData() async {
    var data = await _glumacProvider!
        .get({'Tekst': _searchController.text}); // Modify this line
    setState(() {
      _glumci = data;
    });
  }

  void handleEdit(int id, String ime, String prezime) async {
    await _glumacProvider!.update(id, {
      'ime': ime,
      'prezime': prezime,
      'imePrezime': "$ime $prezime",
    });
    if (context.mounted) {
      Navigator.pop(context);
      loadData();
    }
  }

  void openEditModal(Glumac g) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditGlumacModal(
          glumac: g,
          handleEdit: handleEdit,
        );
      },
    );
  }

  void openDeleteModal(Glumac g) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Brisanje '),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da zelite da obrisete glumca?'),
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
                  await _glumacProvider!.remove(g.glumacId);
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
                            'Ne možete obrisati glumca jer već učestvuje u predstavi!'),
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

  void handleAdd(String ime, String prezime) async {
    await _glumacProvider!.insert({
      'ime': ime,
      'prezime': prezime,
      'imePrezime': "$ime $prezime",
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
        return AddGlumacModal(handleAdd: handleAdd);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_glumci == null) {
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
                    labelText: 'Glumac',
                    hintText: 'Unesite naziv glumca',
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
            height: 520,
            width: double.infinity, // Set the width to take 100% of the screen
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Ime')),
                  DataColumn(label: Text('Prezime')),
                  DataColumn(label: Text('Uredi')),
                  DataColumn(label: Text('Obrisi')),
                ],
                rows: _glumci!.isNotEmpty
                    ? _glumci!.map((glumac) {
                        return DataRow(cells: [
                          DataCell(Text(glumac.ime)),
                          DataCell(Text(glumac.prezime)),
                          DataCell(IconButton(
                            icon: Icon(Icons.edit,
                                color: Theme.of(context).primaryColor),
                            onPressed: () {
                              openEditModal(glumac);
                            },
                          )),
                          DataCell(IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              openDeleteModal(glumac);
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
