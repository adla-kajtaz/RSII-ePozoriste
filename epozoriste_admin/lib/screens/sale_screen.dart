import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/providers.dart';
import 'package:epozoriste_admin/screens/termini_screen.dart';

import 'package:epozoriste_admin/widgets/modals/sale/add_sala_modal.dart';
import 'package:epozoriste_admin/widgets/modals/sale/edit_sala_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaleScreen extends StatefulWidget {
  final int id;
  static const routeName = '/sale';
  const SaleScreen({super.key, required this.id});

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  SaleProvider? _saleProvider;
  List<Sala>? _sale;
  final TextEditingController _searchController =
      TextEditingController(); // Add this line

  @override
  void initState() {
    super.initState();
    _saleProvider = context.read<SaleProvider>();
    loadData();
  }

  void loadData() async {
    var data = await _saleProvider!.get({
      'PozoristeId': widget.id,
      'Tekst': _searchController.text,
    });
    setState(() {
      _sale = data;
    });
  }

  void handleEdit(int id, dynamic request) async {
    await _saleProvider!.update(id, request);
    if (context.mounted) {
      Navigator.pop(context);
      loadData();
    }
  }

  void openEditModal(Sala s) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditSalaModal(sala: s, handleEdit: handleEdit);
      },
    );
  }

  void openDeleteModal(Sala s) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Brisanje '),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da zelite da obrisete salu?'),
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
                  await _saleProvider!.remove(s.salaId);
                  if (context.mounted) {
                    Navigator.pop(context);
                    loadData();
                  }
                } catch (e) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ne možete obrisati ovu salu!'),
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
    request["pozoristeId"] = widget.id;
    await _saleProvider!.insert(request);
    if (context.mounted) {
      Navigator.pop(context);
      loadData();
    }
  }

  void openAddModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddSalaModal(handleAdd: handleAdd);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_sale == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prikaz sala'),
      ),
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
                      labelText: 'Naziv sale',
                      hintText: 'Unesite naziv sale',
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
              width: double.infinity,
              child: DataTable(
                columnSpacing: 0,
                columns: const [
                  DataColumn(label: Text('Naziv')),
                  DataColumn(label: Text('Broj sjedista'), numeric: true),
                  DataColumn(label: Text('Broj redova'), numeric: true),
                  DataColumn(
                      label: Text('Broj sjedista po redu'), numeric: true),
                  DataColumn(
                    numeric: false,
                    label: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("Uredi")],
                      ),
                    ),
                  ),
                  DataColumn(
                    numeric: false,
                    label: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("Obrisi")],
                      ),
                    ),
                  ),
                  DataColumn(
                    numeric: false,
                    label: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("Termini")],
                      ),
                    ),
                  ),
                ],
                rows: _sale!.isNotEmpty
                    ? _sale!.map((sala) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Tooltip(
                                message: sala.naziv,
                                child: Text(
                                  sala.naziv.length > 20
                                      ? "${sala.naziv.substring(0, 20)} ..."
                                      : sala.naziv,
                                ),
                              ),
                            ),
                            DataCell(Text(sala.brSjedista.toString())),
                            DataCell(Text(sala.brRedova.toString())),
                            DataCell(Text(sala.brSjedistaPoRedu.toString())),
                            DataCell(
                              Center(
                                child: IconButton(
                                  icon: Icon(Icons.edit,
                                      color: Theme.of(context).primaryColor),
                                  onPressed: () {
                                    openEditModal(sala);
                                  },
                                ),
                              ),
                            ),
                            DataCell(
                              Center(
                                child: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    openDeleteModal(sala);
                                  },
                                ),
                              ),
                            ),
                            DataCell(
                              Center(
                                child: IconButton(
                                  icon: Icon(Icons.date_range_rounded,
                                      color: Theme.of(context).primaryColor),
                                  onPressed: () {
                                    // navigate to termini screen with salaId
                                    Navigator.pushNamed(
                                      context,
                                      TerminiScreen.routeName,
                                      arguments: sala.salaId,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
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
