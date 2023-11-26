import 'package:epozoriste_mobile/screens/sjedista.dart';
import 'package:flutter/material.dart';
import '../models/termin.dart';
import '../utils/util.dart';

class DetaljiPredstave extends StatefulWidget {
  static const routeName = '/detaljiPredstave';

  final Termin? termin;
  const DetaljiPredstave({super.key, this.termin});

  @override
  State<DetaljiPredstave> createState() => _DetaljiPredstaveState();
}

class _DetaljiPredstaveState extends State<DetaljiPredstave> {
  @override
  Widget build(BuildContext context) {
    Termin? _termin = widget.termin;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 86, 81, 81),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 57, 53, 53),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(225, 195, 178, 178)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'ePozorište',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.red),
              height: 200,
              width: double.infinity,
              child: imageFromBase64String(
                _termin!.predstava!.slika!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    _termin!.predstava!.naziv,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromARGB(224, 255, 255, 255),
                    ),
                  ),
                  Text(
                    _termin.predstava!.vrstaPredstave!.naziv,
                    style: const TextStyle(
                        color: Color.fromARGB(223, 245, 245, 245)),
                  ),
                  Text(
                    "Režija: ${_termin.predstava!.rezija}",
                    style: const TextStyle(
                        color: Color.fromARGB(223, 245, 245, 245)),
                  ),
                  Text(
                    "Kostimografija: ${_termin.predstava!.kostimografija}",
                    style: const TextStyle(
                        color: Color.fromARGB(223, 245, 245, 245)),
                  ),
                  Text(
                    "Scenografija: ${_termin.predstava!.scenografija}",
                    style: const TextStyle(
                        color: Color.fromARGB(223, 245, 245, 245)),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _termin.predstava!.sadrzaj,
                    style: const TextStyle(
                        color: Color.fromARGB(225, 195, 178, 178)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 103, 103, 103),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(children: [
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    '${_termin.datumOdrzavanja.toString().substring(0, 10)}, ${_termin.vrijemeOdrzavanja}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    _termin.sala!.pozoriste!.naziv,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    _termin.sala!.naziv,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Cijena karte: ${_termin.cijenaKarte} KM',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(223, 217, 217, 217),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () async {
                        try {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Sjedista(termin: _termin),
                            ),
                          );
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      child: const Center(
                        child: Text(
                          'Kupi',
                          style: TextStyle(
                            color: Color.fromARGB(225, 86, 81, 81),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
