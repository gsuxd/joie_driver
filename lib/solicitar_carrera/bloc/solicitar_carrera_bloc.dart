import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'solicitar_carrera_event.dart';
part 'solicitar_carrera_state.dart';

class SolicitarCarreraBloc
    extends Bloc<SolicitarCarreraEvent, SolicitarCarreraState> {
  SolicitarCarreraBloc() : super(const SolicitarCarreraInitial()) {
    on<SolicitarCarrera>(_handleSolicitarCarrera);
  }

  void _handleSolicitarCarrera(
      SolicitarCarrera event, Emitter<SolicitarCarreraState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("viaje", jsonEncode(event));
  }
}
