import 'package:flutter/material.dart';
import 'package:joiedriver/home/home.dart';

class CarreraCanceladaChofer extends StatelessWidget {
  const CarreraCanceladaChofer({Key? key}) : super(key: key);

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
                        builder: (context) => const HomeScreen()));
              },
              child:
                  const Text('Volver', style: TextStyle(color: Colors.black)))
        ],
      ),
    );
  }
}
