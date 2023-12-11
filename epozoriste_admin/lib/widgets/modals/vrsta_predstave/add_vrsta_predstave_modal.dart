import 'package:flutter/material.dart';

class AddVrstaPredstaveModal extends StatefulWidget {
  final Function handleAdd;
  const AddVrstaPredstaveModal({
    super.key,
    required this.handleAdd,
  });

  @override
  State<AddVrstaPredstaveModal> createState() => _AddVrstaPredstaveModalState();
}

class _AddVrstaPredstaveModalState extends State<AddVrstaPredstaveModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? naziv;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Dodaj vrstu predstave'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Naziv vrste predstave',
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
