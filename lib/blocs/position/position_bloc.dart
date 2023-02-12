import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:joiedriver/services/services_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../carrera/carrera_bloc.dart';

part 'position_event.dart';
part 'position_state.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  PositionBloc() : super(PositionInitial()) {
    on<GetPositionEvent>(_handleGetPosition);
  }

  bool _backgroundShooted = false;

  void _handleGetPosition(
      GetPositionEvent event, Emitter<PositionState> emit) async {
    emit(PositionLoading());
    await Geolocator.requestPermission();
    try {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();
      final service = GetIt.I.get<FlutterBackgroundService>();
      if (!(await AwesomeNotifications().isNotificationAllowed())) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
      if (!_backgroundShooted) {
        await service.configure(
            iosConfiguration: IosConfiguration(autoStart: true),
            androidConfiguration: AndroidConfiguration(
              autoStartOnBoot: true,
              autoStart: true,
              initialNotificationContent:
                  'Joie Driver esta trabajando en segundo plano',
              initialNotificationTitle: 'Joie Driver',
              isForegroundMode: true,
              onStart: ServicesManager.initialize,
            ));
        _backgroundShooted = true;
      }
      if (jsonDecode(_prefs.getString('user')!)['type'] == 'chofer') {
        event.context
            .read<CarreraBloc>()
            .add(ListenCarrerasEvent(event.context));
      }
      await for (final message in service.on('positionUpdate')) {
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
    } catch (e) {
      emit(PositionError(e.toString()));
    }
  }
}
