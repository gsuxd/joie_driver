import 'package:flutter/material.dart';
import 'package:joiedriver/choose/choose.dart';
import '../register_login_user/conts.dart';
import '../register_login_user/termin_y_condiciones/terminos_y_condiciones.dart';
import 'default_button.dart';

class NoAccount extends StatelessWidget {
  const NoAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '¿No tienes cuenta Joie Driver?',
            style: TextStyle(
              fontSize: 16,
              color: jtextColorSec,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => const TerminosCondicionesUser()));
          //   },
          //   child: const Text(
          //     'Registrate',
          //     style: TextStyle(fontSize: 16),
          //   ),
          // ),

          ButtonDef(
              text: "Registrate",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TerminosCondicionesUser()));
              }),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChooseScreen()));
            },
            child: const Text(
              'Registrate',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
