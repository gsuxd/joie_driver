import 'package:flutter/material.dart';
import '../forget_password/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routename = '/forgot_password';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left)),
        title: const Text(
          "Olvidé mi contraseña",
        ),
      ),
      body: const Body(),
    );
  }
}
