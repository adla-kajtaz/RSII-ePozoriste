import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/kategorija_obavijest.dart';
import 'package:epozoriste_admin/widgets/modals/kategorija_obavijest/add_kategorija_obavijest_modal.dart';
import 'package:epozoriste_admin/widgets/modals/kategorija_obavijest/edit_kategorija_obavijest_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KategorijeObavijestiScreen extends StatefulWidget {
  const KategorijeObavijestiScreen({super.key});

  @override
  State<KategorijeObavijestiScreen> createState() =>
      _KategorijeObavijestiScreenState();
}

class _KategorijeObavijestiScreenState
    extends State<KategorijeObavijestiScreen> {
  KategorijaObavijestProvider? _kategorijaObavijestProvider;
  List<KategorijaObavijest>? _kategorijeObavijesti;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _kategorijaObavijestProvider = context.read<KategorijaObavijestProvider>();
    loadData();
  }

  void loadData() async {
    var data = await _kategorijaObavijestProvider!
        .get({'Tekst': _searchController.text});
    setState(() {
      _kategorijeObavijesti = data;
    });
  }

  void resetSearch() {
    _searchController.text = '';
  }

  void handleEdit(int id, String naziv) async {
    await _kategorijaObavijestProvider!.update(id, {
      'naziv': naziv,
    });
    if (context.mounted) {
      Navigator.pop(context);
      loadData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text('Uspješno ste modifikovali kategoriju!'),
        ),
      );
    }
  }

  void openEditModal(KategorijaObavijest k) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditKategorijaObavijestModal(
            kObavijest: k, handleEdit: handleEdit);
      },
    );
  }

  void openDeleteModal(KategorijaObavijest k) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Brisanje'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da želite da obrišete kategoriju?'),
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
                  await _kategorijaObavijestProvider!
                      .remove(k.obavijestKategorijaId);
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
                            'Ne možete obrisati kategoriju obavijesti jer postoji obavijest u njoj!'),
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

  void handleAdd(String naziv) async {
    await _kategorijaObavijestProvider!.insert({
      'naziv': naziv,
    });
    if (context.mounted) {
      Navigator.pop(context);
      resetSearch();
      loadData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text('Uspješno ste dodali novu kategoriju!'),
        ),
      );
    }
  }

  void openAddModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddKategorijaObavijestModal(handleAdd: handleAdd);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_kategorijeObavijesti == null) {
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
                    labelText: 'Kategorija obavijesti',
                    hintText: 'Unesite naziv kategorije',
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
                rows: _kategorijeObavijesti!.isNotEmpty
                    ? _kategorijeObavijesti!.map((kategorija) {
                        return DataRow(cells: [
                          DataCell(Text(kategorija.naziv)),
                          DataCell(IconButton(
                            icon: Icon(Icons.edit,
                                color: Theme.of(context).primaryColor),
                            onPressed: () {
                              openEditModal(kategorija);
                            },
                          )),
                          DataCell(IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              openDeleteModal(kategorija);
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
