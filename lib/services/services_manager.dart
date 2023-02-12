import 'dart:convert';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:joiedriver/blocs/carrera/carrera_listener.dart';
import 'package:joiedriver/notifications/notification_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'position_service.dart';

class ServicesManager {
  @pragma('vm:entry-point')
  static void initialize(ServiceInstance instance) async {
    DartPluginRegistrant.ensureInitialized();
    WidgetsFlutterBinding.ensureInitialized();
    await initializeNotifications(instance);
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    PositionService.initializeBackground(instance);
    if (jsonDecode(_prefs.getString('user')!)['type'] == 'chofer') {
      CarreraListener.handleListen(instance);
      instance.on('newTrip').listen((e) async {
        print('send notification');
        if ((WidgetsBinding.instance.lifecycleState !=
            AppLifecycleState.resumed)) {
          await AwesomeNotifications().createNotification(
              content: NotificationContent(
                  id: e!['carrera']['numeroPasajeros'],
                  channelKey: 'newTrips',
                  title: 'Nueva carrera a tus alrededores',
                  payload: {
                    'carrera': jsonEncode(e),
                    'carreraRef': e['reference'],
                    'event': 'newTrip'
                  },
                  actionType: ActionType.Default));
        }
      });
    }
  }

  @pragma('vm:entry-point')
  static Future<void> initializeNotifications(instance) async {
    await NotificationController.initializeLocalNotifications();
  }
}
