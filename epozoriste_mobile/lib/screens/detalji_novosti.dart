import 'package:epozoriste_mobile/models/obavijest.dart';
import 'package:flutter/material.dart';

import '../utils/util.dart';

class DetaljiNovosti extends StatefulWidget {
  static const routeName = '/detaljiNovosti';

  final Obavijest? obavijest;
  const DetaljiNovosti({super.key, this.obavijest});

  @override
  State<DetaljiNovosti> createState() => _DetaljiNovostiState();
}

class _DetaljiNovostiState extends State<DetaljiNovosti> {
  @override
  Widget build(BuildContext context) {
    Obavijest? _obavijest = widget.obavijest;
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
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              decoration: BoxDecoration(color: Colors.red),
              height: 200,
              width: double.infinity,
              child: imageFromBase64String(
                _obavijest!.slika!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _obavijest!.naslov,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            _obavijest.korisnik.korisnickoIme.toString(),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 219, 217, 217),
                                fontSize: 10),
                          ),
                          const Text(
                            " | ",
                            style: TextStyle(
                                color: Color.fromARGB(255, 219, 217, 217),
                                fontSize: 10),
                          ),
                          Text(
                            _obavijest.datumKreiranja
                                .toString()
                                .substring(0, 10),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 219, 217, 217),
                                fontSize: 10),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _obavijest.podnaslov,
                        style: const TextStyle(
                            color: Color.fromARGB(225, 195, 178, 178)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _obavijest.sadrzaj,
                        style: const TextStyle(
                            color: Color.fromARGB(225, 195, 178, 178)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
