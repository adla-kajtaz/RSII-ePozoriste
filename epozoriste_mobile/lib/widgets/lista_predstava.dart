import 'package:flutter/material.dart';
import '../models/models.dart';
import '../screens/detalji_predstave.dart';
import '../utils/util.dart';

class ListaPredstava extends StatelessWidget {
  final List<Termin> termini;
  const ListaPredstava({super.key, required this.termini});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: termini.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          final termin = termini[index];
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
                              termin.predstava!.slika!,
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
                          termin.predstava!.naziv,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          '${termin.datumOdrzavanja.toString().substring(0, 10)}, ${termin.vrijemeOdrzavanja}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetaljiPredstave(termin: termin),
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
