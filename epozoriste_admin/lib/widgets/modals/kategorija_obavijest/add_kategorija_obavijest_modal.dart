import 'package:flutter/material.dart';

class AddKategorijaObavijestModal extends StatefulWidget {
  final Function handleAdd;
  const AddKategorijaObavijestModal({
    super.key,
    required this.handleAdd,
  });

  @override
  State<AddKategorijaObavijestModal> createState() =>
      _AddKategorijaObavijestModalState();
}

class _AddKategorijaObavijestModalState
    extends State<AddKategorijaObavijestModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? naziv;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Dodaj kategoriju obavijesti'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Naziv kategorija',
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
              widget.handleAdd(naziv!);
            }
          },
          child: const Text('Dodaj'),
        ),
      ],
    );
  }
}
