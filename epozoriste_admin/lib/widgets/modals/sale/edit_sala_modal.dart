import 'package:epozoriste_admin/models/models.dart';
import 'package:flutter/material.dart';

class EditSalaModal extends StatefulWidget {
  final Sala sala;
  final Function handleEdit;
  const EditSalaModal({
    Key? key,
    required this.sala,
    required this.handleEdit,
  }) : super(key: key);

  @override
  State<EditSalaModal> createState() => _EditSalaModalState();
}

class _EditSalaModalState extends State<EditSalaModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nazivController;
  late TextEditingController _brojRedovaController;
  late TextEditingController _brojSjedistaPoReduController;
  late TextEditingController _ukupanBrojSjedistaController;

  @override
  void initState() {
    super.initState();
    _nazivController = TextEditingController(text: widget.sala.naziv);
    _brojRedovaController =
        TextEditingController(text: widget.sala.brRedova.toString());
    _brojSjedistaPoReduController =
        TextEditingController(text: widget.sala.brSjedistaPoRedu.toString());
    _ukupanBrojSjedistaController =
        TextEditingController(text: widget.sala.brSjedista.toString());
  }

  @override
  void dispose() {
    _nazivController.dispose();
    _brojRedovaController.dispose();
    _brojSjedistaPoReduController.dispose();
    _ukupanBrojSjedistaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Uredi salu'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nazivController,
              decoration: const InputDecoration(
                labelText: 'Naziv ',
                hintText: 'Unesite naziv sale',
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
              dynamic request = {'naziv': _nazivController.text};
              widget.handleEdit(widget.sala.salaId, request);
            }
          },
          child: const Text('Izmjeni'),
        ),
      ],
    );
  }
}
