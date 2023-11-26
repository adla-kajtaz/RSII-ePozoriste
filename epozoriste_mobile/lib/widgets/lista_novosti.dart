import 'package:flutter/material.dart';
import '../models/models.dart';
import '../screens/detalji_novosti.dart';
import '../utils/util.dart';

class ListaNovosti extends StatelessWidget {
  final List<Obavijest> obavijesti;
  const ListaNovosti({super.key, required this.obavijesti});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: obavijesti.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          final obavijest = obavijesti[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: 150,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 95, 94, 94),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Container(
                  height: 150,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: SizedBox.expand(
                            child: imageFromBase64String(
                              obavijest.slika!,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          obavijest.naslov,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Text(
                          obavijest.korisnik.korisnickoIme.toString() +
                              ', ' +
                              obavijest.datumKreiranja
                                  .toString()
                                  .substring(0, 10),
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetaljiNovosti(obavijest: obavijest),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 181, 176, 176)),
                            child: const Text(
                              'Procitaj vise',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 103, 103, 103)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
