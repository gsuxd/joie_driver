import 'package:flutter/material.dart';
import 'package:joiedriver/home_user/home.dart';

class CarreraFinalizadaPasajero extends StatelessWidget {
  const CarreraFinalizadaPasajero({Key? key}) : super(key: key);

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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const HomeScreenUser()));
              },
              child:
                  const Text('Volver', style: TextStyle(color: Colors.white)))
        ],
      ),
    );
  }
}
