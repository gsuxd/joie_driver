import 'package:flutter/material.dart';

import '../../../size_config.dart';
import './components/body_card.dart';

class FotoVehiculo extends StatelessWidget {
  const FotoVehiculo({Key? key}) : super(key: key);
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "fotoVehiculo";
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Por tu seguridad y la nuestra'),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}
