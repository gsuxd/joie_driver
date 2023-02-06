import 'dart:convert';
import 'dart:isolate';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:joiedriver/services/position_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../carrera/carrera_bloc.dart';

part 'position_event.dart';
part 'position_state.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  PositionBloc() : super(PositionInitial()) {
    on<GetPositionEvent>(_handleGetPosition);
  }

  void _handleGetPosition(
      GetPositionEvent event, Emitter<PositionState> emit) async {
    emit(PositionLoading());
    if ((await FlutterIsolate.runningIsolates).isNotEmpty) {
      FlutterIsolate.killAll();
    }
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final ReceivePort port = ReceivePort();
    await Geolocator.requestPermission();
    try {
      await FlutterIsolate.spawn(PositionService.initialize, [
        port.sendPort,
        _prefs.getString('user'),
      ]);
      if (jsonDecode(_prefs.getString('user')!)['type'] == 'chofer') {
        event.context
            .read<CarreraBloc>()
            .add(ListenCarrerasEvent(event.context));
      }
      await for (final message in port) {
        if (message["error"] != null) {
          emit(
            PositionError(
              message["error"],
            ),
          );
          return;
        }
        emit(PositionObtained(
            PositionGetted(message["latitude"], message["longitude"])));
        return;
      }
    } catch (e) {
      emit(PositionError(e.toString()));
    }
  }
}
