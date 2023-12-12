import 'package:epozoriste_admin/models/models.dart';
import 'package:epozoriste_admin/models/zarada.dart';
import 'package:epozoriste_admin/providers/predstava_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZaradaScreen extends StatefulWidget {
  const ZaradaScreen({super.key});

  @override
  State<ZaradaScreen> createState() => _ZaradaScreenState();
}

class _ZaradaScreenState extends State<ZaradaScreen> {
  PredstavaProvider? _predstavaProvider;
  Zarada? _zarada;
  List<Predstava>? _predstave;
  Predstava? _selectedPredstava;
  @override
  void initState() {
    super.initState();
    _predstavaProvider = context.read<PredstavaProvider>();
    loadPredstave();
  }

  void loadData() async {
    var data =
        await _predstavaProvider!.getZarada(_selectedPredstava!.predstavaId);
    setState(() {
      _zarada = data;
    });
  }

  void loadPredstave() async {
    var data = await _predstavaProvider!.get();
    setState(() {
      _predstave = [...data];
      _selectedPredstava = data[0];
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_predstave == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: SizedBox(
                    width: 400,
                    height: 400,
                    child: Column(children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<Predstava>(
                                decoration: InputDecoration(
                                  labelText: 'Predstava',
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                value: _selectedPredstava,
                                onChanged: (Predstava? p) {
                                  setState(() {
                                    _selectedPredstava = p!;
                                    loadData();
                                  });
                                },
                                items: _predstave!
                                    .map<DropdownMenuItem<Predstava>>(
                                        (Predstava p) {
                                  return DropdownMenuItem<Predstava>(
                                    value: p,
                                    child: Text(p.naziv),
                                  );
                                }).toList(),
                              ),
                            ),
                          ]),
                      const SizedBox(height: 30),
                      if (_zarada != null)
                        Container(
                            width: double.infinity,
                            height: 120,
                            color: Theme.of(context).primaryColor,
                            child: Column(
                              children: [
                                Text(
                                  'Zarada: ${_zarada!.ukupnaZarada} KM',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Broj termina: ${_zarada!.brTermina}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Broj prodatih karata: ${_zarada!.brKarata}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ))
                    ])))));
  }
}
