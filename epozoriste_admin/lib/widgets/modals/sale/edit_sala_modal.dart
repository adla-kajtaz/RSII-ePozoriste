import 'package:epozoriste_admin/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      title: const Text('Uredi drzavu'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nazivController,
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
              controller: _brojRedovaController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Broj redova',
              ),
              onChanged: (String value) {
                if (value.isEmpty) return;
                _ukupanBrojSjedistaController.text = (int.parse(value) *
                        int.parse(_brojSjedistaPoReduController.text))
                    .toString();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _brojSjedistaPoReduController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Broj sjedista po redu',
              ),
              onChanged: (String value) {
                if (value.isEmpty) return;
                _ukupanBrojSjedistaController.text =
                    (int.parse(_brojRedovaController.text) * int.parse(value))
                        .toString();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _ukupanBrojSjedistaController,
              keyboardType: TextInputType.number,
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Ukupan broj sjedista',
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
          child: const Text('Ponisti'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              dynamic request = {
                'naziv': _nazivController.text,
                'brRedova': _brojRedovaController.text,
                'brSjedistaPoRedu': _brojSjedistaPoReduController.text,
                'brSjedista': _ukupanBrojSjedistaController.text,
                'pozoristeId': widget.sala.pozoristeId,
              };
              widget.handleEdit(widget.sala.salaId, request);
            }
          },
          child: const Text('Izmjeni'),
        ),
      ],
    );
  }
}
