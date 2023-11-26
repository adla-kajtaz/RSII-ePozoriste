import 'package:epozoriste_mobile/screens/screens.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import '../models/karta.dart';
import '../models/termin.dart';
import 'package:flutter/material.dart';
import '../providers/auth_provider.dart';
import '../providers/karta_provider.dart';
import '../providers/kupovina_provider.dart';

class Sjedista extends StatefulWidget {
  static const routeName = '/sjedista';

  final Termin? termin;
  const Sjedista({super.key, this.termin});

  @override
  State<Sjedista> createState() => _SjedistaState();
}

class _SjedistaState extends State<Sjedista> {
  List<Karta> karte = [];
  List<Karta>? izabranaSjedista = [];
  KartaProvider? _kartaProvider;
  KupovinaProvider? _kupovinaProvider;
  AuthProvider? _authProvider;
  int korisnikId = 0;
  @override
  void initState() {
    super.initState();
    _kartaProvider = context.read<KartaProvider>();
    _kupovinaProvider = context.read<KupovinaProvider>();
    _authProvider = context.read<AuthProvider>();
    loadData();
  }

  Future loadData() async {
    Termin? _termin = widget.termin;

    var tempData = await _kartaProvider?.getByTerminId(_termin!.terminId);
    setState(() {
      karte = tempData!;
      korisnikId = _authProvider!.getLoggedUserId();
    });
  }

  void plati(
      BuildContext context, String paymentIntentId, int kupovinaId) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentId,
        style: ThemeMode.light,
        merchantDisplayName: "ePozoriste",
      ),
    );
    try {
      var result = await Stripe.instance.presentPaymentSheet();
      for (Karta item in izabranaSjedista!) {
        await _kartaProvider!.changeStatus(item.kartaId, kupovinaId);
      }
      Navigator.pushNamed(context, UspjesnaKupovina.routeName);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Termin? _termin = widget.termin;
    if (karte.isEmpty) {
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
            'ePozoriste',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: const Center(
          child: Text(
            'Učitavanje ...',
            style: TextStyle(
              color: Color.fromARGB(225, 195, 178, 178),
            ),
          ),
        ),
      );
    }
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
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _termin!.predstava!.naziv,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Color.fromARGB(225, 195, 178, 178)),
                      ),
                      Text(
                          '${_termin.datumOdrzavanja.toString().substring(0, 10)}, ${_termin.vrijemeOdrzavanja}',
                          style: const TextStyle(color: Colors.white)),
                      Text(_termin.sala!.pozoriste!.naziv,
                          style: const TextStyle(color: Colors.white)),
                      Text(_termin.sala!.naziv,
                          style: const TextStyle(color: Colors.white)),
                      Text('Broj karata: ${izabranaSjedista!.length}',
                          style: const TextStyle(color: Colors.white)),
                      Text(
                          'Ukupna cijena: ${(_termin.cijenaKarte * izabranaSjedista!.length)}KM',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(4)),
                                  width: 20,
                                  height: 20)),
                          const Text("Slobodno",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 113, 12, 12),
                                      border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(4)),
                                  width: 20,
                                  height: 20)),
                          const Text("Izabrano",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 56, 41, 41),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 56, 41, 41),
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(4)),
                                  width: 20,
                                  height: 20)),
                          const Text("Rasprodano",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 350,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 10,
                              children: List.generate(karte.length, (index) {
                                final seat = karte[index];
                                return InkWell(
                                    onTap: () {
                                      if (!seat.aktivna) {
                                        showMessage("Sjedište je zauzeto");
                                      } else if (izabranaSjedista!
                                          .contains(karte[index])) {
                                        setState(() {
                                          izabranaSjedista!
                                              .remove(karte[index]);
                                        });
                                      } else {
                                        setState(() {
                                          izabranaSjedista!.add(karte[index]);
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 1.0,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: (izabranaSjedista!
                                                  .contains(karte[index]))
                                              ? const Color.fromARGB(
                                                  255, 113, 12, 12)
                                              : (seat.aktivna)
                                                  ? Colors.white
                                                  : const Color.fromARGB(
                                                      255, 56, 41, 41)),
                                      margin: const EdgeInsets.all(5),
                                      child: Center(
                                        child: Text(
                                          seat.sjediste,
                                          style: const TextStyle(fontSize: 6),
                                        ),
                                      ),
                                    ));
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(223, 217, 217, 217),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () async {
                          if (izabranaSjedista!.isEmpty)
                            showMessage("Morate izabrati bar jedno sjediste");
                          else {
                            Map novaKupovina = {
                              'kolicina': izabranaSjedista?.length,
                              'cijena': _termin.cijenaKarte *
                                  izabranaSjedista!.length,
                              "datumKupovine": "2023-10-01T10:57:10.439Z",
                              "korisnikId": korisnikId,
                              "terminId": _termin.terminId,
                              "karte": izabranaSjedista!
                                  .map((e) => e.kartaId)
                                  .toList()
                            };
                            var data =
                                await _kupovinaProvider?.insert(novaKupovina);
                            plati(context, data!.paymentIntentId!,
                                data.kupovinaId);
                          }
                        },
                        child: const Center(
                          child: Text(
                            'Plati',
                            style: TextStyle(
                              color: Color.fromARGB(225, 86, 81, 81),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  showMessage(String message) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Message"),
              content: Text(message),
              actions: [
                TextButton(
                    child: const Text("Ok"),
                    onPressed: () => Navigator.pop(context))
              ],
            ));
  }
}
