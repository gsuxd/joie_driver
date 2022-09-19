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
    on<CancelarCarreraEnCursoEvent>(_handleCancelCarrera);
  }

  late BuildContext _context;

  void _handleCancelCarrera(CancelarCarreraEnCursoEvent event,
      Emitter<CarreraEnCursoState> emit) async {
    await event.carreraRef.update({
      'cancelada': true,
    });
    Navigator.of(_context).pop();
  }

  void _handleCargarCarrera(CargarCarreraEnCursoEvent event,
      Emitter<CarreraEnCursoState> emit) async {
    emit(CarreraEnCursoLoading());
    _context = event.context;
    await for (var e in event.carreraRef.snapshots()) {
      final carrera = Carrera.fromJson(e.data());
      if (carrera.pasajeroId ==
          (_context.read<UserBloc>().state as UserLogged).user.email) {
        continue;
      } else if (carrera.choferId ==
          (_context.read<UserBloc>().state as UserLogged).user.email) {
        if (carrera.cancelada) {
          emit(CarreraEnCursoCancelada(carrera));
          break;
        }
        emit(CarreraEnCursoChofer(carreraRef: e.reference, carrera: carrera));
      }
    }
  }
}
