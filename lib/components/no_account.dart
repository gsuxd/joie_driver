import 'package:flutter/material.dart';
import '../register_login_user/conts.dart';
import '../register_login_user/registro/registro.dart';


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
            fontSize: 16,
            color: jtextColorSec,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RegistroUser()));
          },
          child: Text(
            'Registrate',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
