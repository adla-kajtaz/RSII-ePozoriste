import 'package:epozoriste_admin/models/kategorija_obavijest.dart';
import 'package:epozoriste_admin/models/models.dart';
import 'package:flutter/material.dart';

class EditKategorijaObavijestModal extends StatefulWidget {
  final KategorijaObavijest kObavijest;
  final Function handleEdit;
  const EditKategorijaObavijestModal({
    Key? key,
    required this.kObavijest,
    required this.handleEdit,
  }) : super(key: key);

  @override
  State<EditKategorijaObavijestModal> createState() =>
      _EditKategorijaObavijestModalState();
}

class _EditKategorijaObavijestModalState
    extends State<EditKategorijaObavijestModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nazivController;

  @override
  void initState() {
    super.initState();
    _nazivController = TextEditingController(text: widget.kObavijest.naziv);
  }

  @override
  void dispose() {
    _nazivController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Uredi kategoriju obavijesti'),
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
                widget.kObavijest.obavijestKategorijaId,
                _nazivController.text,
              );
            }
          },
          child: const Text('Izmjeni'),
        ),
      ],
    );
  }
}
