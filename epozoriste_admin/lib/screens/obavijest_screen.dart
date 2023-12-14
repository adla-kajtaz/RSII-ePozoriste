import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/kategorija_obavijest.dart';
import 'package:epozoriste_admin/providers/obavijest_provider.dart';
import 'package:epozoriste_admin/utils/util.dart';
import 'package:epozoriste_admin/widgets/modals/obavijesti/add_obavijest_modal.dart';
import 'package:epozoriste_admin/widgets/modals/obavijesti/edit_obavijest_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObavijestiScreen extends StatefulWidget {
  const ObavijestiScreen({super.key});

  @override
  State<ObavijestiScreen> createState() => _ObavijestiScreenState();
}

class _ObavijestiScreenState extends State<ObavijestiScreen> {
  ObavijestProvider? _obavijestProvider;
  KategorijaObavijestProvider? _kategorijaProvider;
  List<Obavijest>? _obavijesti;
  List<KategorijaObavijest> _kategorije = [
    KategorijaObavijest(obavijestKategorijaId: 0, naziv: 'Sve')
  ];
  KategorijaObavijest? _selectedKategorija;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _obavijestProvider = context.read<ObavijestProvider>();
    _kategorijaProvider = context.read<KategorijaObavijestProvider>();
    _selectedKategorija = _kategorije[0];
    loadKategorije();
    loadData();
  }

  void loadKategorije() async {
    var data = await _kategorijaProvider!.get();
    setState(() {
      _kategorije = [..._kategorije, ...data];
    });
  }

  void loadData() async {
    dynamic request = {
      'ObavijestKategorijaId': _selectedKategorija!.obavijestKategorijaId == 0
          ? null
          : _selectedKategorija!.obavijestKategorijaId,
      'Tekst': _searchController.text
    };
    var data = await _obavijestProvider!.get(request);
    setState(() {
      _obavijesti = data;
    });
  }

  void handleEdit(int id, String naslov, String podnaslov, String sadrzaj,
      int kategorijaId, String slika, DateTime datumKreiranja) async {
    await _obavijestProvider!.update(id, {
      'naslov': naslov,
      'podnaslov': podnaslov,
      'sadrzaj': sadrzaj,
      'slika': slika,
      'obavijestKategorijaId': kategorijaId,
      'korisnikId': Authorization.korisnikId,
    });
    if (context.mounted) {
      Navigator.pop(context);
      loadData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text('Uspješno ste modifikovali obavijest!'),
        ),
      );
    }
  }

  void openEditModal(Obavijest o) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditObavijestModal(obavijest: o, handleEdit: handleEdit);
      },
    );
  }

  void openDeleteModal(Obavijest o) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Brisanje'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da želite da obrišete obavijest?'),
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
                  await _obavijestProvider!.remove(o.obavijestId);
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
                        content: Text('Ne možete obrisati obavijest!'),
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

  void handleAdd(String naslov, String podnaslov, String sadrzaj,
      int kategorijaId, String image) async {
    DateTime now = DateTime.now();
    String formattedDate = now.toUtc().toIso8601String();
    dynamic request = {
      'naslov': naslov,
      'podnaslov': podnaslov,
      'sadrzaj': sadrzaj,
      'obavijestKategorijaId': kategorijaId,
      'slika': image,
      'datumKreiranja': formattedDate,
      'korisnikId': Authorization.korisnikId
    };
    await _obavijestProvider!.insert(request);
    if (context.mounted) {
      Navigator.pop(context);
      loadData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text('Uspješno ste dodali novu obavijest!'),
        ),
      );
    }
  }

  void openAddModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddObavijestModal(handleAdd: handleAdd);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_obavijesti == null) {
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
                      labelText: 'Obavijest',
                      hintText: 'Unesite naziv obavijest',
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: DropdownButtonFormField<KategorijaObavijest>(
                    decoration: InputDecoration(
                      labelText: 'Kategorija',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    value: _selectedKategorija,
                    onChanged: (KategorijaObavijest? kat) {
                      setState(() {
                        _selectedKategorija = kat!;
                      });
                    },
                    items: _kategorije
                        .map<DropdownMenuItem<KategorijaObavijest>>(
                            (KategorijaObavijest k) {
                      return DropdownMenuItem<KategorijaObavijest>(
                        value: k,
                        child: Text(k.naziv),
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
                  DataColumn(label: Text('Podnaslov')),
                  DataColumn(label: Text('Datum kreiranja')),
                  DataColumn(label: Text('Obavijest kategorije')),
                  DataColumn(label: Text('Korisnik')),
                  DataColumn(label: Text('Uredi')),
                  DataColumn(label: Text('Obrisi')),
                ],
                rows: _obavijesti!.isNotEmpty
                    ? _obavijesti!.map((obavijest) {
                        return DataRow(cells: [
                          DataCell(
                            Tooltip(
                              message: obavijest.naslov,
                              child: Text(
                                obavijest.naslov.length > 20
                                    ? "${obavijest.naslov.substring(0, 20)} ..."
                                    : obavijest.naslov,
                              ),
                            ),
                          ),
                          DataCell(
                            Tooltip(
                              message: obavijest.podnaslov,
                              child: Text(
                                obavijest.podnaslov.length > 20
                                    ? "${obavijest.podnaslov.substring(0, 20)} ..."
                                    : obavijest.podnaslov,
                              ),
                            ),
                          ),
                          DataCell(Text(obavijest.datumKreiranja
                              .toString()
                              .substring(0, 10))),
                          DataCell(
                            Tooltip(
                              message: obavijest.obavijestKategorija!.naziv,
                              child: Text(
                                obavijest.obavijestKategorija!.naziv.length > 20
                                    ? "${obavijest.obavijestKategorija!.naziv.substring(0, 20)} ..."
                                    : obavijest.obavijestKategorija!.naziv,
                              ),
                            ),
                          ),
                          DataCell(Text(obavijest.korisnik.korisnickoIme!)),
                          DataCell(IconButton(
                            icon: Icon(Icons.edit,
                                color: Theme.of(context).primaryColor),
                            onPressed: () {
                              openEditModal(obavijest);
                            },
                          )),
                          DataCell(IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              openDeleteModal(obavijest);
                            },
                          )),
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
