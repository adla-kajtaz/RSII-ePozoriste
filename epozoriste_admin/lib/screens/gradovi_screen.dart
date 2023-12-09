import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/drzava_provider.dart';
import 'package:epozoriste_admin/providers/gradovi_provider.dart';
import 'package:epozoriste_admin/widgets/modals/gradovi/add_grad_modal.dart';
import 'package:epozoriste_admin/widgets/modals/gradovi/edit_grad_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GradoviScreen extends StatefulWidget {
  const GradoviScreen({super.key});

  @override
  State<GradoviScreen> createState() => _GradoviScreenState();
}

class _GradoviScreenState extends State<GradoviScreen> {
  GradoviProvider? _gradoviProvider;
  DrzavaProvider? _drzavaProvider;
  List<Grad>? _gradovi;
  List<Drzava> _drzave = [Drzava(drzavaId: 0, naziv: 'Sve', skracenica: 'skr')];
  Drzava? _selectedDrzava;
  final TextEditingController _searchController =
      TextEditingController(); // Add this line
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _gradoviProvider = context.read<GradoviProvider>();
    _drzavaProvider = context.read<DrzavaProvider>();
    _selectedDrzava = _drzave[0];
    loadDrzave();
    loadData();
  }

  void loadDrzave() async {
    var data = await _drzavaProvider!.get(); // Modify this line
    setState(() {
      _drzave = [..._drzave, ...data];
    });
  }

  void loadData() async {
    dynamic request = {
      'DrzavaId':
          _selectedDrzava!.drzavaId == 0 ? null : _selectedDrzava!.drzavaId,
      'Tekst': _searchController.text
    };

    var data = await _gradoviProvider!.get(request); // Modify this line
    setState(() {
      _gradovi = data;
    });
  }

  void handleEdit(int id, String naziv, String skracenica, int drzavaId) async {
    await _gradoviProvider!.update(id, {
      'naziv': naziv,
      'postanskiBr': skracenica,
      'drzavaId': drzavaId,
    });
    if (context.mounted) {
      Navigator.pop(context);
      loadData();
    }
  }

  void openEditModal(Grad grad) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditGradModal(grad: grad, handleEdit: handleEdit);
      },
    );
  }

  void openDeleteModal(Grad grad) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Brisanje '),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurno da zelite da obrisete grad?'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ponisti'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _gradoviProvider!.remove(grad.gradId);
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
                            'Ne možete obrisati grad jer postoji pozoriste u njemu!'),
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

  void handleAdd(String naziv, String skracenica, int drzavaId) async {
    await _gradoviProvider!.insert({
      'naziv': naziv,
      'postanskiBr': skracenica,
      'drzavaId': drzavaId,
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
        return AddGradModal(
          handleAdd: handleAdd,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_gradovi == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 16.0),
              Expanded(
                child: TextFormField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Grad',
                    hintText: 'Unesite naziv grada',
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: DropdownButtonFormField<Drzava>(
                  decoration: InputDecoration(
                    labelText: 'Drzava',
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  value: _selectedDrzava,
                  onChanged: (Drzava? drz) {
                    setState(() {
                      _selectedDrzava = drz!;
                    });
                  },
                  items: _drzave.map<DropdownMenuItem<Drzava>>((Drzava d) {
                    return DropdownMenuItem<Drzava>(
                      value: d,
                      child: Text(d.naziv),
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
            height: 300,
            width: double.infinity, // Set the width to take 100% of the screen
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Naziv')),
                DataColumn(label: Text('Postanski broj')),
                DataColumn(label: Text('Naziv drzave')),
                DataColumn(label: Text('Uredi')),
                DataColumn(label: Text('Obrisi')),
              ],
              rows: _gradovi!.isNotEmpty
                  ? _gradovi!.map((grad) {
                      return DataRow(cells: [
                        DataCell(Text(grad.naziv)),
                        DataCell(Text(grad.postanskiBr)),
                        DataCell(Text(grad.drzava!.naziv)),
                        DataCell(IconButton(
                          icon: Icon(Icons.edit,
                              color: Theme.of(context).primaryColor),
                          onPressed: () {
                            openEditModal(grad);
                          },
                        )),
                        DataCell(IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            openDeleteModal(grad);
                          },
                        )),
                      ]);
                    }).toList()
                  : [
                      const DataRow(cells: [
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(
                            Center(child: Text('Nema rezultata pretrage'))),
                        DataCell(Text('')),
                        DataCell(Text('')),
                      ])
                    ],
            ),
          ),
        ],
      ),
    );
  }
}
