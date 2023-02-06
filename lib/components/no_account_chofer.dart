import 'package:flutter/material.dart';
import 'package:joiedriver/registro/pages/terminos_condiciones/terminos_condiciones.dart';
import '../conts.dart';
import '../size_config.dart';

class NoAccountChofer extends StatelessWidget {
  const NoAccountChofer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿No tienes cuenta Joie Driver?',
          style: TextStyle(
            fontSize: getPropertieScreenWidth(16),
            color: jtextColorSec,
          ),
        ),
        SizedBox(
          width: getPropertieScreenWidth(10),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TerminosCondiciones()));
          },
          child: Text(
            'Registrate',
            style: TextStyle(fontSize: getPropertieScreenWidth(16)),
          ),
        ),
      ],
    );
  }
}
