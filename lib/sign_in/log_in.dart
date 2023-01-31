import 'package:flutter/material.dart';
import '../sign_in/components/body.dart';
import '../size_config.dart';

class LognInScreenUser extends StatelessWidget {
  static String routename = "/login";
  const LognInScreenUser({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Iniciar Sesión",
        ),
        centerTitle: true,
      ),
      body: const BodySign(),
    );
  }
}
