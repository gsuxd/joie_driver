import 'package:flutter/material.dart';
import 'components/body_banco.dart';


class DatosBanco extends StatelessWidget {
  static String routeName = '/datos_banco';
  const DatosBanco({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left)),
        title: const Text('Completar Perfil'),
      ),
      body: const Body(),
    );
  }
}