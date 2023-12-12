import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/vrsta_predstave_provider.dart';
import 'package:epozoriste_admin/widgets/modals/vrsta_predstave/add_vrsta_predstave_modal.dart';
import 'package:epozoriste_admin/widgets/modals/vrsta_predstave/edit_vrsta_predstave_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VrstePredstaveScreen extends StatefulWidget {
  const VrstePredstaveScreen({super.key});

  @override
  State<VrstePredstaveScreen> createState() => _VrstePredstaveScreenState();
}

class _VrstePredstaveScreenState extends State<VrstePredstaveScreen> {
  VrstaPredstaveProvider? _vrstaPredstaveProvider;
  List<VrstaPredstave>? _vrstePredstave;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _vrstaPredstaveProvider = context.read<VrstaPredstaveProvider>();
    loadData();
  }

  void loadData() async {
    var data =
        await _vrstaPredstaveProvider!.get({'Tekst': _searchController.text});
    setState(() {
      _vrstePredstave = data;
    });
  }

  void handleEdit(int id, String naziv) async {
    await _vrstaPredstaveProvider!.update(id, {
      'naziv': naziv,
    });
    if (context.mounted) {
      Navigator.pop(context);
      loadData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text('Uspješno ste modifikovali vrstu!'),
        ),
      );
    }
  }

  void openEditModal(VrstaPredstave v) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditVrstaPredstaveModal(vPredstave: v, handleEdit: handleEdit);
      },
    );
  }

  void openDeleteModal(VrstaPredstave v) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Brisanje '),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da želite da obrišete vrstu?'),
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
                  await _vrstaPredstaveProvider!.remove(v.vrstaPredstaveId);
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
                            'Ne možete obrisati vrstu predstave jer postoji predstava vezana za nju.'),
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

  void handleAdd(String naziv) async {
    await _vrstaPredstaveProvider!.insert({
      'naziv': naziv,
    });
    if (context.mounted) {
      Navigator.pop(context);
      loadData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text('Uspješno ste dodali novu vrstu!'),
        ),
      );
    }
  }

  void openAddModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddVrstaPredstaveModal(handleAdd: handleAdd);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_vrstePredstave == null) {
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
                    labelText: 'Vrsta predstave',
                    hintText: 'Unesite vrstu predstave',
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
            width: double.infinity,
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Naziv')),
                  DataColumn(label: Text('Uredi')),
                  DataColumn(label: Text('Obrisi')),
                ],
                rows: _vrstePredstave!.isNotEmpty
                    ? _vrstePredstave!.map((vPredstava) {
                        return DataRow(cells: [
                          DataCell(Text(vPredstava.naziv)),
                          DataCell(IconButton(
                            icon: Icon(Icons.edit,
                                color: Theme.of(context).primaryColor),
                            onPressed: () {
                              openEditModal(vPredstava);
                            },
                          )),
                          DataCell(IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              openDeleteModal(vPredstava);
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
