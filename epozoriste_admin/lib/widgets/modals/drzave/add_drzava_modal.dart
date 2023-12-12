import 'package:flutter/material.dart';

class AddDrzavaModal extends StatefulWidget {
  final Function handleAdd;
  const AddDrzavaModal({
    super.key,
    required this.handleAdd,
  });

  @override
  State<AddDrzavaModal> createState() => _AddDrzavaModalState();
}

class _AddDrzavaModalState extends State<AddDrzavaModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? naziv;
  String? skracenica;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Dodaj državu'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Naziv države',
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
              maxLength: 3,
              decoration: const InputDecoration(
                labelText: 'Skraćenica',
              ),
              onChanged: (value) {
                skracenica = value;
              },
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
