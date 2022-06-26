import 'package:flutter/material.dart';

import '../../forget_password/forget_password.dart';


class ForgotButtom extends StatelessWidget {
  const ForgotButtom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ForgotPasswordScreen()));
      },
      child: const Text("Olvide mi contraseña"));
  }
}