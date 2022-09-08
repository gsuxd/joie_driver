import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/blocs/carrera/carrera_model.dart';

import 'bloc/carrera_en_curso_bloc.dart';

class CarreraEnCursoPage extends StatefulWidget {
  const CarreraEnCursoPage({Key? key, required this.carrera}) : super(key: key);

  final Carrera carrera;

  @override
  State<CarreraEnCursoPage> createState() => _CarreraEnCursoPageState();
}

class _CarreraEnCursoPageState extends State<CarreraEnCursoPage> {
  @override
  void initState() {
    context
        .read<CarreraEnCursoBloc>()
        .add(CargarCarreraEnCursoEvent(widget.carrera.pasajeroId, context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<CarreraEnCursoBloc, CarreraEnCursoState>(
          builder: (context, state) {
            if (state is CarreraEnCursoCancelada) {
              return const Text('Carrera cancelada');
            }

            if (state is CarreraEnCursoLoading) {
              return const CircularProgressIndicator();
            }

            return const Text('Carrera en curso');
          },
        ),
      ),
    );
  }
}
