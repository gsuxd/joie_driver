import 'package:flutter/material.dart';
import '../size_config.dart';

import 'components/body.dart';

class SplashScreen extends StatelessWidget {
  static String routename = "/splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //inicia el sistema de medición automático de medidas
    SizeConfig().init(context);
    return const Scaffold(
      body:
          //Inicia el cuerpo del onboarding screen
          Body(),
    );
  }
}
