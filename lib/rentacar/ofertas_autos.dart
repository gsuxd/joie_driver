import 'package:joie_driver/components/default_button.dart';
import 'package:joie_driver/routes.dart';
import 'package:flutter/material.dart';


import 'package:joie_driver/size_config.dart';
import 'package:joie_driver/screens/ofertas_autos/components/body.dart';

class OfertasAutos extends StatefulWidget {
  static String routeName = "/ofertas_autos";
  const OfertasAutos({Key? key}) : super(key: key);

  @override
  _OfertasAutosState createState() => _OfertasAutosState();
}

class _OfertasAutosState extends State<OfertasAutos> {
  @override
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.keyboard_arrow_left)),
          title: const Text('Bogota')),
      body: const Body(),
    );
  }
}
