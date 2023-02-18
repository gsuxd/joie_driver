import 'dart:convert';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:joiedriver/blocs/carrera/carrera_listener.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'position_service.dart';

class ServicesManager {
  @pragma('vm:entry-point')
  static void initialize(ServiceInstance instance) async {
    DartPluginRegistrant.ensureInitialized();
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (jsonDecode(_prefs.getString('user')!)['type'] == 'chofer') {
      PositionService.initializeBackground(instance);
      CarreraListener.handleListen(instance);
    }
  }
}
