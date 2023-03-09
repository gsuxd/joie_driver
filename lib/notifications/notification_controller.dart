import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:joiedriver/blocs/carrera/carrera_listener.dart';
import 'package:joiedriver/blocs/carrera/carrera_model.dart';
import 'package:joiedriver/helpers/get_city.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class NotificationController {
  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  @pragma("vm:entry-point")
  static Future<void> initializeLocalNotifications() async {
    onBackgroundMessage();
    final instance = FirebaseMessaging.instance;
    await instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onMessageOpenedApp.listen(onActionReceivedMethod);
    final prefs = await SharedPreferences.getInstance();
    final user = jsonDecode(prefs.getString("userData")!);
    if (user['type'] == "chofer") {
      final city = await getCity(await Geolocator.getCurrentPosition());
      await FirebaseMessaging.instance
          .subscribeToTopic('newTrips-${city.replaceAll(" ", "-")}');
    }
  }

  @pragma("vm:entry-point")
  static Future<void> onBackgroundMessage() async {
    final RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      onActionReceivedMethod(message);
    }
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(RemoteMessage message) async {
    CarreraListener.showBackgroundModal(
        Carrera.fromJson(jsonDecode(message.data['carrera']!)),
        message.data['ref']!,
        MyApp.navigatorKey);
  }

  ///  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  ///
  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = MyApp.navigatorKey.currentContext!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Get Notified!',
                style: Theme.of(context).textTheme.titleLarge),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/animated-bell.gif',
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Permite el acceso a las notificaciones'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Denegar',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    userAuthorized = true;
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Permitir',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.deepPurple),
                  )),
            ],
          );
        });
    return userAuthorized;
  }
}
