import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/blocs/carrera/carrera_bloc.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<CarreraBloc, CarreraState>(
      builder: (context, state) {
        if (state is CarreraEnEspera) {
          return ListView(
            children: <Widget>[
              Text(state.carrera.inicio.toString()),
              Text(state.carrera.destino.toString()),
            ],
          );
        }
        if (state is CarreraEnCurso) {
          return const Text("en curso");
        }
        return const Center(child: Text("State error, please try again"));
      },
    ));
  }
}
