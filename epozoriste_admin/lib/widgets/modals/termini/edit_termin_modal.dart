import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/providers.dart';
import 'package:epozoriste_admin/providers/termin_provider.dart';
import 'package:epozoriste_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditTerminModal extends StatefulWidget {
  final Termin termin;
  final Function handleEdit;
  const EditTerminModal({
    Key? key,
    required this.termin,
    required this.handleEdit,
  }) : super(key: key);

  @override
  State<EditTerminModal> createState() => _EditPozoristeModalState();
}

class _EditPozoristeModalState extends State<EditTerminModal> {
  TerminProvider? _terminProvider;
  PredstavaProvider? _predstavaProvider;
  List<Predstava> _predstave = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Predstava? _selectedPredstava;
  bool displayError = false;

  late TextEditingController cijenaKarteController;
  late TextEditingController vrijemeOdrzavanjaController;

  late DateTime datumOdrzavanja;
  late bool isPremijera;
  late bool isPredPremijera;

  @override
  void initState() {
    super.initState();
    _terminProvider = context.read<TerminProvider>();
    _predstavaProvider = context.read<PredstavaProvider>();
    cijenaKarteController =
        TextEditingController(text: widget.termin.cijenaKarte.toString());
    vrijemeOdrzavanjaController =
        TextEditingController(text: widget.termin.vrijemeOdrzavanja);

    isPremijera = widget.termin.premijera;
    isPredPremijera = widget.termin.predpremijera;
    datumOdrzavanja = widget.termin.datumOdrzavanja;
    loadPredstave();
  }

  loadPredstave() async {
    var data = await _predstavaProvider!.get();
    _predstave = data;
    int index = data.indexWhere(
        (element) => element.predstavaId == widget.termin.predstavaId);

    setState(() {
      _predstave = data;
      _selectedPredstava = data[index];
    });
  }

  @override
  void dispose() {
    cijenaKarteController.dispose();
    vrijemeOdrzavanjaController.dispose();
    super.dispose();
  }

  void handleEdit(int id, dynamic request) async {
    try {
      await _terminProvider!.update(id, request);
      if (context.mounted) {
        Navigator.pop(context);
        widget.handleEdit();
      }
    } catch (e) {
      if (context.mounted) {
        setState(() {
          displayError = true;
        });
      }
    }
  }

  Future<void> handleSelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: datumOdrzavanja,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != datumOdrzavanja) {
      setState(() {
        datumOdrzavanja = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Uredjivanje termina'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButtonFormField<Predstava>(
              decoration: InputDecoration(
                labelText: 'Predstava',
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
              value: _selectedPredstava,
              onChanged: (Predstava? p) {
                setState(() {
                  _selectedPredstava = p!;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Ovo polje je obavezno';
                }
                return null;
              },
              items: _predstave.map<DropdownMenuItem<Predstava>>((Predstava p) {
                return DropdownMenuItem<Predstava>(
                  value: p,
                  child: Text(p.naziv),
                );
              }).toList(),
            ),
            TextFormField(
              controller: cijenaKarteController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Cijena karte (KM)',
                hintText: 'Unesite cijenu karte',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => handleSelectDate(context),
                  child: Text(
                    formatDateTime(datumOdrzavanja),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: vrijemeOdrzavanjaController,
              decoration: const InputDecoration(
                  labelText: 'Satnica održavanja', hintText: ''),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: isPremijera,
                  onChanged: (bool? s) {
                    setState(() {
                      isPremijera = s!;
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),
                const Text('Premijera'),
                const SizedBox(width: 16),
                Checkbox(
                  value: isPredPremijera,
                  onChanged: (bool? s) {
                    setState(() {
                      isPredPremijera = s!;
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),
                const Text('Predpremijera'),
              ],
            ),
            const SizedBox(height: 16),
            if (displayError)
              const Text('Termin za ovaj datum i vrijeme je zauzet.',
                  style: TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
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
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              dynamic request = {
                'premijera': isPremijera,
                'predpremijera': isPredPremijera,
                'cijenaKarte': cijenaKarteController.text,
                'datumOdrzavanja': datumOdrzavanja.toIso8601String(),
                'vrijemeOdrzavanja': vrijemeOdrzavanjaController.text,
                'predstavaId': _selectedPredstava!.predstavaId,
                'salaId': widget.termin.salaId
              };

              handleEdit(widget.termin.terminId, request);
            }
          },
          child: const Text('Dodaj'),
        ),
      ],
    );
  }
}
