import 'package:flutter/material.dart';

class AddGlumacModal extends StatefulWidget {
  final Function handleAdd;
  const AddGlumacModal({
    super.key,
    required this.handleAdd,
  });

  @override
  State<AddGlumacModal> createState() => _AddGlumacModalState();
}

class _AddGlumacModalState extends State<AddGlumacModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? naziv;
  String? skracenica;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Dodaj glumca'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Ime glumca',
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
                labelText: 'Prezime glumca',
              ),
              onChanged: (value) {
                skracenica = value;
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
              widget.handleAdd(naziv!, skracenica!);
            }
          },
          child: const Text('Dodaj'),
        ),
      ],
    );
  }
}
