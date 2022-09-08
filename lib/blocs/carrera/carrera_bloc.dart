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
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:joiedriver/carrera_en_curso/carrera_en_curso_chofer.dart';
import 'package:joiedriver/helpers/calculate_distance.dart';

import 'carrera_model.dart';
import 'widgets/nueva_carrera_modal.dart';

part 'carrera_event.dart';
part 'carrera_state.dart';

class CarreraBloc extends Bloc<CarreraEvent, CarreraState> {
  CarreraBloc() : super(CarreraInitial()) {
    on<ListenCarrerasEvent>(_handleListen);
    on<NuevaCarreraEvent>(_handleNuevaCarrera);
    on<OfertarCarreraEvent>(_handleOfertarCarrera);
  }

  late BuildContext context;

  void _handleOfertarCarrera(
      OfertarCarreraEvent event, Emitter<CarreraState> emit) async {
    emit(CarreraLoading());
    final user = (context.read<UserBloc>().state as UserLogged).user;
    final carrera = await FirebaseFirestore.instance
        .collection('carreras')
        .where('pasajeroId', isEqualTo: event.pasajeroId)
        .get();
    carrera.docs.last.reference.update({
      'ofertas': FieldValue.arrayUnion([
        Oferta(
            chofer: user.name,
            thumb: user.profilePicture,
            choferId: user.email,
            calificacion: 4,
            precio: event.precioOferta!)
      ])
    });
    emit(CarreraInitial());
  }

  void _handleNuevaCarrera(
      NuevaCarreraEvent event, Emitter<CarreraState> emit) async {
    final Carrera carrera = event.carrera;
    await FirebaseFirestore.instance
        .collection('carreras')
        .add(carrera.toJson());
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
          distance: distance,
          choferIcon: choferIcon,
          iconPasajero: NetworkImage(iconPasajero),
          location: LatLng(location.latitude!, location.longitude!),
          polypoints: polypoints,
          aPoint: aPoint,
          bPoint: bPoint,
        ),
      ),
    );
  }

  void _handleSnapshot(QuerySnapshot<Map<String, dynamic>> val) {
    final carreras = val.docs;
    if (carreras.length != _carrerasCercanasCount) {
      final x = Carrera.fromJson(carreras.last);
      final distance = calculateDistance(
          x.inicio,
          LatLng(
              (context.read<PositionBloc>().state as PositionObtained)
                  .location
                  .latitude!,
              (context.read<PositionBloc>().state as PositionObtained)
                  .location
                  .longitude!));
      if (distance < 5) {
        if (DateTime.now().difference(x.fecha).inSeconds > 120 ||
            x.aceptada == true) {
          val.docs.last.reference.delete();
          return;
        }
        if (x.aceptada) {
          if (x.choferId == FirebaseAuth.instance.currentUser!.email) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => CarreraEnCursoPage(
                      carrera: x,
                    )));
          }
          return;
        }
        _carrerasCercanasCount = carreras.length;
        _showModal(x);
      }
    }
  }

  void _handleListen(
      ListenCarrerasEvent event, Emitter<CarreraState> emit) async {
    final userCollection =
        FirebaseFirestore.instance.collection('carreras').snapshots();
    context = event.context;
    userCollection.listen(_handleSnapshot);
  }
}
