import 'package:flutter/material.dart';
import '../register_login_chofer/conts.dart';
import '../register_login_chofer/size_config.dart';
import '../register_login_chofer/splash/components/default_button.dart';
import '../register_login_chofer/termin_y_condiciones/terminos_y_condiciones.dart';

class NoAccountChofer extends StatelessWidget {
  const NoAccountChofer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.only(
        bottom: 20, left: 10, right: 10
    ),
    child:  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿No tienes cuenta Joie Driver?',
          style: TextStyle(
            fontSize: getPropertieScreenWidth(18),
            color: jtextColorSec,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ButtonDef(
            text: "Registrate",
            press: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TerminosCondiciones()));
            }
        ),
      ],
    )
      );
  }
}