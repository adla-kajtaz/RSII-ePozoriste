import 'package:epozoriste_admin/models/models.dart';
import 'package:flutter/material.dart';

class EditGlumacModal extends StatefulWidget {
  final Glumac glumac;
  final Function handleEdit;
  const EditGlumacModal({
    Key? key,
    required this.glumac,
    required this.handleEdit,
  }) : super(key: key);

  @override
  State<EditGlumacModal> createState() => _EditGlumacModalState();
}

class _EditGlumacModalState extends State<EditGlumacModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _imeController;
  late TextEditingController _prezimeController;

  @override
  void initState() {
    super.initState();
    _imeController = TextEditingController(text: widget.glumac.ime);
    _prezimeController = TextEditingController(text: widget.glumac.prezime);
  }

  @override
  void dispose() {
    _imeController.dispose();
    _prezimeController.dispose();
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
              controller: _imeController,
              decoration: const InputDecoration(
                labelText: 'Ime ',
                hintText: 'Unesite ime glumca',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _prezimeController,
              decoration: const InputDecoration(
                labelText: 'Prezime',
                hintText: 'Unesite prezime glumca',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno';
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
                widget.glumac.glumacId,
                _imeController.text,
                _prezimeController.text,
              );
            }
          },
          child: const Text('Izmjeni'),
        ),
      ],
    );
  }
}
