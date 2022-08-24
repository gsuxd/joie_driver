import 'package:flutter/material.dart';
import 'package:joiedriver/choose/choose.dart';
import '../register_login_user/conts.dart';
import '../register_login_user/termin_y_condiciones/terminos_y_condiciones.dart';

class NoAccount extends StatelessWidget {
  const NoAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ChooseScreen()));
          },
          child: const Text(
            'Registrate',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
