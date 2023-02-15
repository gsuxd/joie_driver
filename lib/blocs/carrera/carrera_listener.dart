import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/helpers/get_polyline_points.dart';
import 'package:joiedriver/helpers/get_user_collection.dart';
import 'package:joiedriver/notifications/notification_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../position/position_bloc.dart';
import 'package:joiedriver/helpers/calculate_distance.dart';

import 'carrera_model.dart';
import 'widgets/nueva_carrera_modal.dart';

class CarreraListener {
  BuildContext context;
  CarreraListener(this.context, {this.carrerasCercanasSubscription});
  static ServiceInstance? _instance;

  ///Handle Snapshot
  ///Handles the snapshot incoming from the database
  static void handleSnapshot(QuerySnapshot<Map<String, dynamic>> val) async {
    final prefs = await SharedPreferences.getInstance();
    final u = await jsonDecode(prefs.getString('user')!);
    final ignoreList =
        (await getUserCollection(u["type"]).doc(u["email"]).get()).data();
    final List<QueryDocumentSnapshot<Map<String, dynamic>>?> carreras = [];
    for (var e in val.docs) {
      if (!((ignoreList!['carrerasIgnoradas'] as List).contains(e.id))) {
        carreras.add(e);
      }
    }
    int _carrerasCercanasCount = 0;
    if (carreras.isNotEmpty && carreras.length != _carrerasCercanasCount) {
      final x = Carrera.fromJson(carreras.last);
      final pos = await Geolocator.getCurrentPosition();
      final distance =
          calculateDistance(x.inicio, LatLng(pos.latitude, pos.longitude));
      if (distance <= 5) {
        _carrerasCercanasCount = carreras.length;
        if (x.aceptada) {
          if (x.choferId == u['email']) {
            if (!(x.finalizada)) {
              _instance?.invoke('tripAccepted', {
                'carrera': x.toJson(),
                'reference': carreras.last!.reference.path
              });
              return;
            }
          }
          await getUserCollection(u["type"]).doc(u["email"]).update({
            'carrerasIgnoradas': FieldValue.arrayUnion([carreras.last!.id])
          });
          return;
        }
        if (x.ofertas
            .where((element) => element.choferId == u['email'])
            .isNotEmpty) {
          return;
        }
        _instance?.invoke('newTrip', {
          'reference': carreras.last!.reference.path,
          'carrera': carreras.last!.data()
        });
        _sendNoti({
          'reference': carreras.last!.reference.path,
          'carrera': carreras.last!.data()
        });
        return;
      }
      await getUserCollection(u["type"]).doc(u["email"]).update({
        'carrerasIgnoradas': FieldValue.arrayUnion([carreras.last!.id])
      });
      return;
    }
  }

  ///carrerasCercanasSubscription
  ///Subscription to carreras updates
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
      carrerasCercanasSubscription;
  @pragma('vm:entry-point')
  static void _sendNoti(data) async {
    final port = IsolateNameServer.lookupPortByName('tripsEvents')!;
    port.send({'event': 'newTrip', 'data': data});
  }

  ///_handlelisten
  ///Updates the context and the carrerasCercanasSubscription
  @pragma('vm:entry-point')
  static void handleListen(ServiceInstance instance) async {
    try {
      DartPluginRegistrant.ensureInitialized();
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      _instance = instance;
      final collection =
          FirebaseFirestore.instance.collection('carreras').snapshots();
      await for (final snap in collection) {
        handleSnapshot(snap);
      }
    } catch (e) {
      _instance?.invoke('tripError', {"error": e.toString()});
    }
  }

  static void showBackgroundModal(
      Carrera carrera, String carreraRef, GlobalKey<NavigatorState> key) async {
    final polypoints = await getPolypoints(carrera.inicio, carrera.destino);
    final distance = calculateDistance(carrera.inicio, carrera.destino);
    final location = await Geolocator.getCurrentPosition();
    final iconSize = distance < 5
        ? distance > 3
            ? 12.0
            : 4.0
        : 13.0;
    final choferIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(iconSize, iconSize)),
        "assets/images/coches-en-el-mapa.png");

    final aPoint = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(iconSize, iconSize)),
        "assets/images/pint-A-indicator.png");

    final bPoint = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(iconSize, iconSize)),
        "assets/images/pint-B-indicator.png");

    final iconPasajero = await FirebaseStorage.instance
        .ref()
        .child("${carrera.pasajeroId}/ProfilePhoto.jpg")
        .getDownloadURL();

    key.currentState!.push(
      MaterialPageRoute(
        builder: (_) => NuevaCarreraModal(
          carrera: carrera,
          carreraRef: FirebaseFirestore.instance.doc(carreraRef),
          distance: distance,
          choferIcon: choferIcon,
          iconPasajero: NetworkImage(iconPasajero),
          location: LatLng(location.latitude, location.longitude),
          polypoints: polypoints,
          aPoint: aPoint,
          bPoint: bPoint,
        ),
      ),
    );
  }

  ///Shows a modal for a new carrera
  static void showModal(
      Carrera carrera,
      DocumentReference<Map<String, dynamic>> carreraRef,
      BuildContext context) async {
    final polypoints = await getPolypoints(carrera.inicio, carrera.destino);
    final distance = calculateDistance(carrera.inicio, carrera.destino);
    final location =
        (context.read<PositionBloc>().state as PositionObtained).location;
    final iconSize = distance < 5
        ? distance > 3
            ? 12.0
            : 4.0
        : 13.0;
    final choferIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(iconSize, iconSize)),
        "assets/images/coches-en-el-mapa.png");

    final aPoint = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(iconSize, iconSize)),
        "assets/images/pint-A-indicator.png");

    final bPoint = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(iconSize, iconSize)),
        "assets/images/pint-B-indicator.png");

    final iconPasajero = await FirebaseStorage.instance
        .ref()
        .child("${carrera.pasajeroId}/ProfilePhoto.jpg")
        .getDownloadURL();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NuevaCarreraModal(
          carrera: carrera,
          carreraRef: carreraRef,
          distance: distance,
          choferIcon: choferIcon,
          iconPasajero: NetworkImage(iconPasajero),
          location: LatLng(location.latitude, location.longitude),
          polypoints: polypoints,
          aPoint: aPoint,
          bPoint: bPoint,
        ),
      ),
    );
  }
}
