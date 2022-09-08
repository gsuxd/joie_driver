import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/blocs/carrera/carrera_model.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';

part 'carrera_en_curso_event.dart';
part 'carrera_en_curso_state.dart';

class CarreraEnCursoBloc
    extends Bloc<CarreraEnCursoEvent, CarreraEnCursoState> {
  CarreraEnCursoBloc() : super(CarreraEnCursoInitial()) {
    on<CargarCarreraEnCursoEvent>(_handleCargarCarrera);
  }

  late BuildContext context;

  void _handleCargarCarrera(CargarCarreraEnCursoEvent event,
      Emitter<CarreraEnCursoState> emit) async {
    emit(CarreraEnCursoLoading());
    context = event.context;
    await for (var e in context.read<UserBloc>().userSnapshot.snapshots()) {
      final carreras =
          (e.get('carrerasCercanas') as List).map((e) => Carrera.fromJson(e));
      for (var carrera in carreras) {
        if (carrera.pasajeroId ==
            (context.read<UserBloc>().state as UserLogged).user.email) {
          break;
        } else if (carrera.choferId ==
            (context.read<UserBloc>().state as UserLogged).user.email) {
          if (carrera.cancelada) {
            emit(CarreraEnCursoCancelada(carrera));
            break;
          }
        }
      }
    }
  }
}
