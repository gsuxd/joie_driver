import 'package:flutter/material.dart';
import '../register_login_chofer/conts.dart';
import '../register_login_chofer/size_config.dart';
import '../register_login_chofer/termin_y_condiciones/terminos_y_condiciones.dart';

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
            fontSize: getPropertieScreenWidth(18),
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
            style: TextStyle(fontSize: getPropertieScreenWidth(20)),
          ),
        ),
      ],
    );
  }
}