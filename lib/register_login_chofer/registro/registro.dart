import 'package:flutter/material.dart';

import 'components/body.dart';

class Registro extends StatelessWidget {
  static String routeName = '/registro';
  const Registro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.keyboard_arrow_left, size: 30,)),
          title: const Text('Registro')),
      body: const Body(),
    );
  }
}
