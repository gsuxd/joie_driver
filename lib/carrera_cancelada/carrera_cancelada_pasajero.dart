import 'package:flutter/material.dart';
import 'package:joiedriver/home_user/home.dart';

class CarreraCanceladaPasajero extends StatelessWidget {
  const CarreraCanceladaPasajero({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrera Cancelada'),
      ),
      body: Column(
        children: [
          const Center(
            child: Text('Carrera Cancelada'),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreenUser()));
              },
              child: const Text('Volver'))
        ],
      ),
    );
  }
}
