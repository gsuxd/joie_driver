import 'dart:convert';
import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:geolocator/geolocator.dart';
import 'package:joiedriver/helpers/get_user_collection.dart';
import 'package:joiedriver/singletons/user_data.dart';

abstract class PositionService {
  @pragma('vm:entry-point')
  static void initialize(args) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    SendPort port = args[0];
    final user = UserData.fromJson(jsonDecode(args[1]));
    try {
      CollectionReference collection = getUserCollection(user.type);

      final userRef = collection.doc(user.email);
      await for (final value in Geolocator.getPositionStream()) {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(value.latitude, value.longitude);
        var first = placemarks.first;
        await userRef.update({
          "location": {
            "latitude": value.latitude,
            "longitude": value.longitude
          },
          "city": first.locality,
        });
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
