import 'package:flutter/material.dart';
import 'package:joiedriver/conts.dart';
import '../registro/main.dart';

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
                MaterialPageRoute(builder: (context) => const Registro()));
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
