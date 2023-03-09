import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:geolocator/geolocator.dart';
import 'package:joiedriver/blocs/user/user_enums.dart';
import 'package:joiedriver/singletons/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PositionService {
  static Future<void> _sendData(
      Position value, DocumentReference<Object?> userRef) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(value.latitude, value.longitude);
    var first = placemarks.first;
    await userRef.update({
      "location": {"latitude": value.latitude, "longitude": value.longitude},
      "city": first.locality,
    });
  }

  @pragma('vm:entry-point')
  static void initializeBackground(ServiceInstance instance) async {
    DartPluginRegistrant.ensureInitialized();
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final user = UserData.fromJson(jsonDecode(_prefs.getString('user')!));
    try {
      final userRef =
          FirebaseFirestore.instance.collection("users").doc(user.email);
      await for (final value in Geolocator.getPositionStream()) {
        await _sendData(value, userRef);
        instance.invoke('positionUpdate', {
          'latitude': value.latitude,
          'longitude': value.longitude,
        });
      }
    } catch (e) {
      instance.invoke('positionUpdate', {"error": e.toString()});
      return;
    }
  }

  @pragma('vm:entry-point')
  static void initialize(args) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    SendPort port = args[0];
    final user = UserData.fromJson(args[1]);
    try {
      final userRef =
          FirebaseFirestore.instance.collection("users").doc(user.email);
      await for (final value in Geolocator.getPositionStream()) {
        if (user.type == UserType.chofer) {
          await _sendData(value, userRef);
        }
        port.send({
          'latitude': value.latitude,
          'longitude': value.longitude,
        });
      }
    } catch (e) {
      port.send({"error": e.toString()});
      return;
    }
  }
}
