import 'package:epozoriste_admin/models/models.dart';
import 'package:flutter/material.dart';

class EditDrzavaModal extends StatefulWidget {
  final Drzava drzava;
  final Function handleEdit;
  const EditDrzavaModal({
    Key? key,
    required this.drzava,
    required this.handleEdit,
  }) : super(key: key);

  @override
  State<EditDrzavaModal> createState() => _EditDrzavaModalState();
}

class _EditDrzavaModalState extends State<EditDrzavaModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nazivController;
  late TextEditingController _skracenicaController;

  @override
  void initState() {
    super.initState();
    _nazivController = TextEditingController(text: widget.drzava.naziv);
    _skracenicaController =
        TextEditingController(text: widget.drzava.skracenica);
  }

  @override
  void dispose() {
    _nazivController.dispose();
    _skracenicaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Uredi drzavu'),
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
              controller: _skracenicaController,
              maxLength: 3,
              decoration: const InputDecoration(
                labelText: 'Skracenica',
                hintText: 'Skracenica',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno';
                }
                if (value.length > 3) {
                  return 'Skraćenica može sadržavati najviše 3 slova';
                }
                return null;
              },
            ),
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
            if (_formKey.currentState!.validate()) {
              widget.handleEdit(
                widget.drzava.drzavaId,
                _nazivController.text,
                _skracenicaController.text,
              );
            }
          },
          child: const Text('Izmjeni'),
        ),
      ],
    );
  }
}
