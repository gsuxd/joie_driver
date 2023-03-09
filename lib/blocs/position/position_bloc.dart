import 'dart:convert';
import 'dart:isolate';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:joiedriver/notifications/notification_controller.dart';
import 'package:joiedriver/services/position_service.dart';
import 'package:joiedriver/services/services_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../carrera/carrera_bloc.dart';

part 'position_event.dart';
part 'position_state.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  PositionBloc() : super(PositionInitial()) {
    on<GetPositionEvent>(_handleGetPosition);
  }
  @override
  Future<void> close() async {
    FlutterIsolate.killAll();
    super.close();
  }

  bool _backgroundShooted = false;

  void _handleGetPosition(
      GetPositionEvent event, Emitter<PositionState> emit) async {
    emit(PositionLoading());
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final user = jsonDecode(_prefs.getString('user')!);
    final hasPermission = await Geolocator.checkPermission();
    if (user['type'] == "chofer" &&
        hasPermission != LocationPermission.always) {
      await Geolocator.requestPermission();
    } else if (hasPermission != LocationPermission.whileInUse) {
      await Geolocator.requestPermission();
      if (user['type'] == "chofer") {
        await Geolocator.requestPermission();
      }
    }
    try {
      await NotificationController.initializeLocalNotifications();
      final service = GetIt.I.get<FlutterBackgroundService>();
      ReceivePort port;
      if (!_backgroundShooted) {
        if (user['type'] == 'chofer') {
          await service.configure(
              iosConfiguration: IosConfiguration(autoStart: false),
              androidConfiguration: AndroidConfiguration(
                autoStart: false,
                autoStartOnBoot: true,
                initialNotificationContent:
                    'Joie Driver esta trabajando en segundo plano',
                initialNotificationTitle: 'Joie Driver',
                isForegroundMode: false,
                onStart: ServicesManager.initialize,
              ));
          event.context
              .read<CarreraBloc>()
              .add(ListenCarrerasEvent(event.context));
        }
        if ((await FlutterIsolate.runningIsolates).isNotEmpty) {
          FlutterIsolate.killAll();
        }
        port = ReceivePort('positionUpdates');
        await FlutterIsolate.spawn(
            PositionService.initialize, [port.sendPort, user]);
        _backgroundShooted = true;
        await _listenPorts(port.asBroadcastStream(), emit);
      }
    } catch (e) {
      emit(PositionError(e.toString()));
    }
  }

  Future<void> _listenPorts(Stream stream, Emitter<PositionState> emit) async {
    await for (final message in stream) {
      if (message!["error"] != null) {
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
  }
}
