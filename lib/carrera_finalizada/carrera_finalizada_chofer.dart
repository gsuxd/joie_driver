import 'package:flutter/material.dart';

import '../home/home.dart';

class CarreraFinalizadaChofer extends StatelessWidget {
  const CarreraFinalizadaChofer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
            child: Text('Carrera Finalizada'),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              child:
                  const Text('Volver', style: TextStyle(color: Colors.white)))
        ],
      ),
    );
  }
}
