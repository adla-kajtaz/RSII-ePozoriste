import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/providers/providers.dart';
import 'package:epozoriste_admin/providers/termin_provider.dart';
import 'package:epozoriste_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddTerminModal extends StatefulWidget {
  final int salaId;
  final Function handleAdd;
  const AddTerminModal(
      {super.key, required this.salaId, required this.handleAdd});

  @override
  State<AddTerminModal> createState() => _AddTerminModalState();
}

class _AddTerminModalState extends State<AddTerminModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PredstavaProvider? _predstaveProvider;
  List<Predstava> _predstave = [];
  TerminProvider? _terminProvider;
  Predstava? _selectedPredstava;
  int cijenaKarte = 0;
  DateTime datumOdrzavanja = DateTime.now();
  String satnicaOdrzavanja = '20:00';
  bool isPremijera = false;
  bool isPredPremijera = false;
  bool displayError = false;
  @override
  void initState() {
    super.initState();
    _predstaveProvider = context.read<PredstavaProvider>();
    _terminProvider = context.read<TerminProvider>();
    loadKategorije();
  }

  void loadKategorije() async {
    var data = await _predstaveProvider!.get();
    setState(() {
      _predstave = data;
    });
  }

  void handleAdd(dynamic request) async {
    request['salaId'] = widget.salaId;
    try {
      await _terminProvider!.insert(request);
      if (context.mounted) {
        Navigator.pop(context);
        widget.handleAdd();
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
      title: const Text('Dodavanje termina'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Cijena karte (KM)',
              ),
              onChanged: (String value) {
                if (value.isEmpty) return;
                cijenaKarte = int.parse(value);
                setState(() {
                  cijenaKarte = int.parse(value);
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            const Text('Datum održavanja'),
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
              initialValue: '20:00',
              decoration: const InputDecoration(
                labelText: 'Satnica održavanja',
              ),
              onChanged: (String value) {
                setState(() {
                  satnicaOdrzavanja = value;
                });
              },
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
            const SizedBox(height: 16)
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
                'cijenaKarte': cijenaKarte,
                'datumOdrzavanja': datumOdrzavanja.toIso8601String(),
                'vrijemeOdrzavanja': satnicaOdrzavanja,
                'predstavaId': _selectedPredstava!.predstavaId
              };

              handleAdd(request);
            }
          },
          child: const Text('Dodaj'),
        ),
      ],
    );
  }
}
