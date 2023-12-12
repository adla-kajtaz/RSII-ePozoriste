import 'package:epozoriste_admin/models/karta.dart';
import 'package:flutter/material.dart';

class PregledKarata extends StatelessWidget {
  final int brojRedova;
  final int brojSjedistaPoRedu;
  final int brSjedista;
  final int brojSlobodnih;
  final int brojZauzetih;
  final List<Karta> _karte;

  const PregledKarata({
    super.key,
    required this.brojRedova,
    required this.brojSjedistaPoRedu,
    required this.brSjedista,
    required this.brojSlobodnih,
    required this.brojZauzetih,
    required karte,
  }) : _karte = karte;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(width: 20, height: 20, color: Colors.yellow),
              const SizedBox(width: 10),
              Text('Slobodno: $brojSlobodnih')
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(width: 20, height: 20, color: Colors.red),
              const SizedBox(width: 10),
              Text('Zauzeto: $brojZauzetih')
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            width: 600,
            child: GridView.builder(
              itemCount: _karte.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: brojSjedistaPoRedu,
              ),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: _karte[index].aktivna ? Colors.yellow : Colors.red,
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      _karte[index].sjediste,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
