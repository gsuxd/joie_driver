import 'package:flutter/material.dart';

import '../size_config.dart';

import 'components/body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

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
