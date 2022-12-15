import 'package:flutter/material.dart';
import '../../../register_login_chofer/forget_password/forget_password.dart';


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
                builder: (context) => const ForgotPasswordScreen()));
      },
      child: const Text("Olvide mi contraseña", style: TextStyle(fontSize: 18,),));
  }
}