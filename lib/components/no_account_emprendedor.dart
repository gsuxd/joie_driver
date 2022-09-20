import 'package:flutter/material.dart';
import '../register_login_emprendedor/conts.dart';
import '../register_login_emprendedor/size_config.dart';
import '../register_login_emprendedor/termin_y_condiciones/terminos_y_condiciones.dart';

class NoAccountEmprendedor extends StatelessWidget {
  const NoAccountEmprendedor({
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
        SizedBox(
          width: getPropertieScreenWidth(10),
        ),
      ],
    );
  }
}
