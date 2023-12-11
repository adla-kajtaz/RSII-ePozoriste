import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/predstava_glumac_provider.dart';
import 'package:epozoriste_admin/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddGlumacPredstavaModal extends StatefulWidget {
  final int predstavaId;
  final String nazivPredstave;
  const AddGlumacPredstavaModal({
    super.key,
    required this.nazivPredstave,
    required this.predstavaId,
  });

  @override
  State<AddGlumacPredstavaModal> createState() => _AddGlumacModalState();
}

class _AddGlumacModalState extends State<AddGlumacPredstavaModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PredstavaGlumacProvider? _predstavaGlumacProvider;
  GlumacProvider? _glumacProvider;
  List<Glumac> _glumci = [];

  late TextEditingController nazivController;
  String? uloga;
  Glumac? _selectedGlumac;

  @override
  void initState() {
    super.initState();
    _predstavaGlumacProvider = context.read<PredstavaGlumacProvider>();
    _glumacProvider = context.read<GlumacProvider>();
    nazivController = TextEditingController(text: widget.nazivPredstave);
    loadGlumci();
  }

  void loadGlumci() async {
    var data = await _glumacProvider!.get();
    setState(() {
      _glumci = data;
    });
  }

  void handleAdd() async {
    dynamic request = {
      "nazivUloge": uloga,
      "glumacId": _selectedGlumac!.glumacId,
      "predstavaId": widget.predstavaId,
    };
    await _predstavaGlumacProvider!.insert(request);
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    nazivController.dispose();
    super.dispose();
  }

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
              enabled: false,
              controller: nazivController,
              decoration: const InputDecoration(
                labelText: 'Naziv predstave',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Naziv uloge',
              ),
              onChanged: (value) {
                uloga = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno';
                }
                return null;
              },
            ),
            SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField<Glumac>(
                decoration: InputDecoration(
                  labelText: 'Glumac',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
                value: _selectedGlumac,
                onChanged: (Glumac? g) {
                  setState(() {
                    _selectedGlumac = g!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Molimo odaberite državu';
                  }
                  return null;
                },
                items: _glumci.map<DropdownMenuItem<Glumac>>((Glumac g) {
                  return DropdownMenuItem<Glumac>(
                    value: g,
                    child: Text("${g.ime} ${g.prezime}"),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              handleAdd();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
