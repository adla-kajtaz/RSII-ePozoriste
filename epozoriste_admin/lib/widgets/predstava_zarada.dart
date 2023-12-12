import 'package:epozoriste_admin/models/zarada.dart';
import 'package:epozoriste_admin/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PredstavaZarada extends StatefulWidget {
  final int predstavaId;
  const PredstavaZarada({
    super.key,
    required this.predstavaId,
  });

  @override
  State<PredstavaZarada> createState() => _PredstavaZaradaState();
}

class _PredstavaZaradaState extends State<PredstavaZarada> {
  PredstavaProvider? _predstavaProvider;
  Zarada? _zarada;
  @override
  void initState() {
    super.initState();
    _predstavaProvider = context.read<PredstavaProvider>();
    loadData();
  }

  void loadData() async {
    var data = await _predstavaProvider!.getZarada(widget.predstavaId);
    setState(() {
      _zarada = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_zarada == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Zarada: ${_zarada!.ukupnaZarada} KM',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Broj termina: ${_zarada!.brTermina}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Broj prodatih karata: ${_zarada!.brKarata}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
