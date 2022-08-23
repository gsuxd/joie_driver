import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/helpers/calculate_distance.dart';

import 'carrera_model.dart';

part 'carrera_event.dart';
part 'carrera_state.dart';

class CarreraBloc extends Bloc<CarreraEvent, CarreraState> {
  CarreraBloc() : super(CarreraInitial()) {
    on<ListenCarrerasEvent>(_handleListen);
    on<NuevaCarreraEvent>(_handleNuevaCarrera);
  }

  void _handleNuevaCarrera(
      NuevaCarreraEvent event, Emitter<CarreraState> emit) async {
    final Carrera carrera = event.carrera;
    await FirebaseFirestore.instance
        .collection('carreras')
        .add(carrera.toJson());
    emit(CarreraEnEspera(carrera));
  }

  void _handleListen(
      ListenCarrerasEvent event, Emitter<CarreraState> emit) async {
    print('handle listen');
    final carreras =
        FirebaseFirestore.instance.collection('carreras').snapshots();
    await for (final val in carreras) {
      for (var element in val.docs) {
        final x = Carrera.fromJson(element.data());
        if (x.aceptada) {
          continue;
        }
        print('emitir carrera');
      }
    }
  }
}
