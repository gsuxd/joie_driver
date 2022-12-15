import 'package:flutter/material.dart';
import 'components/body.dart';

class RegistroEmprendedor extends StatelessWidget {
  static String routeName = '/registro';
  const RegistroEmprendedor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.keyboard_arrow_left)),
          title: const Text('Registro')),
      body: const Body(),
    );
  }
}
