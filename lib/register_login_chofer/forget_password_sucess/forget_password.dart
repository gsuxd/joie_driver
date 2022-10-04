import 'package:flutter/material.dart';
import 'body.dart';

class ForgotPasswordScreenSucessChofer extends StatelessWidget {
  static String routename = '/forgot_password';
  const ForgotPasswordScreenSucessChofer({Key? key}) : super(key: key);

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
      body: const BodySucessChofer(),
    );
  }
}
