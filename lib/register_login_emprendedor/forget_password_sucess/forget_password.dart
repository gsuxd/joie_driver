import 'package:flutter/material.dart';
import 'body.dart';

class ForgotPasswordScreenSucess extends StatelessWidget {
  static String routename = '/forgot_password';
  const ForgotPasswordScreenSucess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        title: const Text(
          "Olvidé mi contraseña",
        ),
      ),
      body: const BodySucess(),
    );
  }
}
