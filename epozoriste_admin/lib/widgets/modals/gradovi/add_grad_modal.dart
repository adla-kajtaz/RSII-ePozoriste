import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/drzava_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddGradModal extends StatefulWidget {
  final Function handleAdd;
  const AddGradModal({
    super.key,
    required this.handleAdd,
  });

  @override
  State<AddGradModal> createState() => _AddGradModalState();
}

class _AddGradModalState extends State<AddGradModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DrzavaProvider? _drzavaProvider;
  Drzava? _selectedDrzava;
  List<Drzava> _drzave = [];
  String? naziv;
  String? postanskiBroj;
  @override
  void initState() {
    super.initState();
    _drzavaProvider = context.read<DrzavaProvider>();
    loadDrzave();
  }

  void loadDrzave() async {
    var data = await _drzavaProvider!.get();
    setState(() {
      _drzave = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Dodaj grad'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Naziv grada',
              ),
              onChanged: (value) {
                naziv = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Postanski broj',
              ),
              onChanged: (value) {
                postanskiBroj = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno';
                }
                return null;
              },
            ),
            SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField<Drzava>(
                decoration: InputDecoration(
                  labelText: 'Drzava',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
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
                validator: (value) {
                  if (value == null) {
                    return 'Molimo odaberite državu';
                  }
                  return null;
                },
                items: _drzave.map<DropdownMenuItem<Drzava>>((Drzava d) {
                  return DropdownMenuItem<Drzava>(
                    value: d,
                    child: Text(d.naziv),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Poništi'),
        ),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              widget.handleAdd(
                  naziv!, postanskiBroj!, _selectedDrzava!.drzavaId);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
