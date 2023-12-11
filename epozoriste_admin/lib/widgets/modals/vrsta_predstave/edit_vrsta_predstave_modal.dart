import 'package:epozoriste_admin/models/models.dart';
import 'package:flutter/material.dart';

class EditVrstaPredstaveModal extends StatefulWidget {
  final VrstaPredstave vPredstave;
  final Function handleEdit;
  const EditVrstaPredstaveModal({
    Key? key,
    required this.vPredstave,
    required this.handleEdit,
  }) : super(key: key);

  @override
  State<EditVrstaPredstaveModal> createState() =>
      _EditVrstaPredstaveModalState();
}

class _EditVrstaPredstaveModalState extends State<EditVrstaPredstaveModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nazivController;

  @override
  void initState() {
    super.initState();
    _nazivController = TextEditingController(text: widget.vPredstave.naziv);
  }

  @override
  void dispose() {
    _nazivController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Uredi vrstu predstave'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nazivController,
              decoration: const InputDecoration(
                labelText: 'Naziv vrste predstave',
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
                widget.vPredstave.vrstaPredstaveId,
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
