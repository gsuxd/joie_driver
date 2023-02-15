import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:joiedriver/blocs/carrera/carrera_listener.dart';
import 'package:joiedriver/main.dart';
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
      final port = ReceivePort('tripsEvents');
      IsolateNameServer.registerPortWithName(port.sendPort, 'tripsEvents');
      CarreraListener.handleListen(instance);
      await for (final message in port) {
        try {
          if (MyApp.navigatorKey.currentContext == null) {
            await NotificationController.createNewNotification(
                channelKey: 'newTrips',
                title: 'Nueva carrera a tus alrededores',
                body: '',
                payload: {
                  'carrera': jsonEncode(message!['data']['carrera']),
                  'carreraRef': message['data']['reference'],
                  'event': 'newTrip'
                });
          }
        } catch (e) {
          print('error sending Notification: ${e.toString()}');
        }
      }
    }
  }

  @pragma('vm:entry-point')
  static Future<void> initializeNotifications(instance) async {
    await NotificationController.initializeLocalNotifications();
  }
}
