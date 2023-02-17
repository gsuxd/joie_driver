import 'package:flutter/material.dart';
import 'components/body_vehiculo.dart';

class DatosVehiculo extends StatelessWidget {
  const DatosVehiculo({Key? key}) : super(key: key);
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "datosVehiculo";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left)),
        title: const Text('Datos Vehiculo'),
      ),
      body: const Body(),
    );
  }
}
