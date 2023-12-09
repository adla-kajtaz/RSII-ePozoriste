import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/drzava_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditGradModal extends StatefulWidget {
  final Grad grad;
  final Function handleEdit;

  const EditGradModal({
    Key? key,
    required this.grad,
    required this.handleEdit,
  }) : super(key: key);

  @override
  State<EditGradModal> createState() => _EditGradModalState();
}

class _EditGradModalState extends State<EditGradModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nazivController;
  late TextEditingController _postanskiController;
  DrzavaProvider? _drzavaProvider;
  Drzava? _selectedDrzava;
  List<Drzava> _drzave = [];
  @override
  void initState() {
    super.initState();
    _nazivController = TextEditingController(text: widget.grad.naziv);
    _postanskiController = TextEditingController(text: widget.grad.postanskiBr);
    _drzavaProvider = context.read<DrzavaProvider>();
    loadDrzave();
  }

  void loadDrzave() async {
    var data = await _drzavaProvider!.get();
    setState(() {
      _drzave = data;
      int index = data.indexWhere(
          (element) => element.drzavaId == widget.grad.drzava!.drzavaId);
      _selectedDrzava = data[index];
    });
  }

  @override
  void dispose() {
    _nazivController.dispose();
    _postanskiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Uredi grad'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nazivController,
              decoration: const InputDecoration(
                labelText: 'Naziv',
                hintText: 'Naziv',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _postanskiController,
              decoration: const InputDecoration(
                labelText: 'Skracenica',
                hintText: 'Skracenica',
              ),
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
          child: const Text('Ponisti'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.handleEdit(
                widget.grad.gradId,
                _nazivController.text,
                _postanskiController.text,
                _selectedDrzava!.drzavaId,
              );
            }
          },
          child: const Text('Izmjeni'),
        ),
      ],
    );
  }
}
