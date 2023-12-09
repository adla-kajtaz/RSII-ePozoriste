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
            if (formKey.currentState!.validate()) {
              widget.handleAdd(naziv!, skracenica!);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
