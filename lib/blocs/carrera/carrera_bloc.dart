import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:joiedriver/colors.dart';
import 'package:joiedriver/helpers/calculate_distance.dart';

import 'carrera_model.dart';
import 'widgets/nueva_carrera_modal.dart';

part 'carrera_event.dart';
part 'carrera_state.dart';

class CarreraBloc extends Bloc<CarreraEvent, CarreraState> {
  CarreraBloc() : super(CarreraInitial()) {
    on<ListenCarrerasEvent>(_handleListen);
    on<NuevaCarreraEvent>(_handleNuevaCarrera);
  }

  void _handleNuevaCarrera(
      NuevaCarreraEvent event, Emitter<CarreraState> emit) async {
    final Carrera carrera = event.carrera;
    final autos =
        await FirebaseFirestore.instance.collection('usersPasajeros').get();
    final List<DocumentReference<Map<String, dynamic>>> futures = [];
    for (var element in autos.docs) {
      final data = element.data();
      if (data['name'] != 'ASD') {
        continue;
      }
      final distance = calculateDistance(
          LatLng(
            carrera.inicio.latitude,
            carrera.inicio.longitude,
          ),
          LatLng(data['location']['latitude'], data['location']['longitude']));
      if (distance < 5) {
        futures.add(element.reference);
      }
    }
    for (var element in futures) {
      await element.update({
        'carrerasCercanas': FieldValue.arrayUnion([carrera.toJson()]),
      });
    }
    emit(CarreraEnEspera(carrera));
  }

  int _carrerasCercanasCount = 0;

  Future<PolylineResult> getPolyPoints(
      LatLng location, LatLng destination) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAEE30voT1-ycMD3-cxpq2m4oJcKrpLeRA",
      PointLatLng(location.latitude, location.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    return result;
  }

  void _showModal(Carrera carrera) async {
    final polypoints = await getPolyPoints(carrera.inicio, carrera.destino);
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

    final iconPasajero = await FirebaseStorage.instance
        .ref()
        .child("${carrera.pasajeroId}/ProfilePhoto.jpg")
        .getDownloadURL();

    showModalBottomSheet(
        context: context,
        builder: (_) => NuevaCarreraModal(
              carrera: carrera,
              distance: distance,
              choferIcon: choferIcon,
              iconPasajero: NetworkImage(iconPasajero),
              location: LatLng(location.latitude!, location.longitude!),
              polypoints: polypoints,
            ));
  }

  void _handleSnapshot(val) {
    final data = val.data();
    final carreras = data!['carrerasCercanas'] as List<dynamic>;
    if (carreras.length != _carrerasCercanasCount) {
      final x = Carrera.fromJson(carreras.last);
      if (DateTime.now().difference(x.fecha).inSeconds > 120) {
        user.update({
          'carrerasCercanas': FieldValue.arrayRemove([x.toJson()]),
        });
        return;
      }
      if (x.aceptada) {
        return;
      }
      _carrerasCercanasCount = carreras.length;
      _showModal(x);
    }
  }

  late BuildContext context;

  final DocumentReference<Map<String, dynamic>> user = FirebaseFirestore
      .instance
      .collection('usersPasajeros')
      .doc(FirebaseAuth.instance.currentUser!.email);

  void _handleListen(
      ListenCarrerasEvent event, Emitter<CarreraState> emit) async {
    final userCollection = user.snapshots();
    context = event.context;
    userCollection.listen(_handleSnapshot);
  }
}
