import 'package:flutter/material.dart';
import '../register_login_user/conts.dart';
import '../register_login_chofer/registro/registro.dart';
import '../register_login_chofer/size_config.dart';

class NoAccount extends StatelessWidget {
  const NoAccount({
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
                    builder: (context) => const Registro()));
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