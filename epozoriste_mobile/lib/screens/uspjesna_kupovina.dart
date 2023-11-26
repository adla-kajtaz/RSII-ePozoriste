import 'package:epozoriste_mobile/screens/screens.dart';
import 'package:flutter/material.dart';

class UspjesnaKupovina extends StatelessWidget {
  static const routeName = '/uspjesnaKupovina';

  const UspjesnaKupovina({super.key});

  final IconData _icon = Icons.check_circle_outlined;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 86, 81, 81),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          const Text(
                            'Uspješna kupovina',
                            style: TextStyle(fontSize: 32, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Icon(
                            _icon,
                            size: 30,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: InkWell(
                              onTap: () => Navigator.popAndPushNamed(
                                  context, Navigacija.routeName),
                              borderRadius: BorderRadius.circular(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(223, 217, 217, 217),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 50,
                                width: double.infinity,
                                child: const Center(
                                  child: Text(
                                    'Idi na početnu',
                                    style: TextStyle(
                                        color: Color.fromARGB(225, 86, 81, 81),
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
