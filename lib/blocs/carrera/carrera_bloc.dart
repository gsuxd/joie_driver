import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:joiedriver/carrera_en_curso/bloc/carrera_en_curso_bloc.dart';
import 'package:joiedriver/carrera_en_curso/carrera_en_curso_chofer.dart';
import 'package:joiedriver/helpers/calculate_distance.dart';
import 'package:joiedriver/home/home.dart';
import 'package:joiedriver/solicitar_carrera/pages/waiting_screen.dart';

import 'carrera_model.dart';
import 'widgets/nueva_carrera_modal.dart';

part 'carrera_event.dart';
part 'carrera_state.dart';

class CarreraBloc extends Bloc<CarreraEvent, CarreraState> {
  CarreraBloc() : super(CarreraInitial()) {
    on<ListenCarrerasEvent>(_handleListen);
    on<NuevaCarreraEvent>(_handleNuevaCarrera);
    on<OfertarCarreraEvent>(_handleOfertarCarrera);
    on<AceptarOfertaEvent>(_handleAceptarOferta);
  }

  late BuildContext context;

  void _handleAceptarOferta(
      AceptarOfertaEvent event, Emitter<CarreraState> emit) async {
    emit(CarreraLoading());
    await event.carreraRef
        .update({'choferId': event.choferId, 'aceptada': true});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(event.choferId)
        .update({
      'active': false,
    });
    _carrerasCercanasSubscription?.cancel();
    _carrerasCercanasSubscription = null;
    emit(
      CarreraEnCurso(
        event.carreraRef,
        Carrera.fromJson(
          (await event.carreraRef.get()).data(),
        ),
      ),
    );
  }

  void _handleOfertarCarrera(
      OfertarCarreraEvent event, Emitter<CarreraState> emit) async {
    emit(CarreraLoading());
    final user = (context.read<UserBloc>().state as UserLogged).user;
    try {
      await event.carreraRef.update({
        'ofertas': FieldValue.arrayUnion([
          Oferta(
                  chofer: user.name,
                  thumb: user.profilePicture,
                  choferId: user.email,
                  calificacion: 4,
                  precio: event.precioOferta!,
                  tardanza: event.tardanza)
              .toJson()
        ])
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
      _carrerasOfertada.add({
        "id": event.carreraRef.id,
        "subscription":
            event.carreraRef.snapshots().listen(_handleSnapshotOferta)
      });
    } catch (e) {
      e;
    }
    emit(CarreraInitial());
  }

  final List<Map<String, dynamic>> _carrerasOfertada = [];

  @override
  Future<void> close() async {
    for (var element in _carrerasOfertada) {
      element['subscription'].cancel();
    }
    if (_carrerasCercanasSubscription != null) {
      _carrerasCercanasSubscription!.cancel();
    }
    return super.close();
  }

  void _handleSnapshotOferta(DocumentSnapshot<Map<String, dynamic>> e) {
    final carrera = Carrera.fromJson(e.data());
    final condicion = carrera.ofertas
        .where((element) =>
            element.choferId ==
            (context.read<UserBloc>().state as UserLogged).user.email)
        .isEmpty;
    if (condicion) {
      _carrerasOfertada.removeWhere((element) => element['id'] == e.id);
      return;
    }
    if (carrera.aceptada &&
        carrera.choferId ==
            (context.read<UserBloc>().state as UserLogged).user.email) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => CarreraEnCursoBloc(),
            child: CarreraEnCursoPage(
              carreraRef: e.reference,
              carrera: carrera,
            ),
          ),
        ),
      );
    }
  }

  void _handleNuevaCarrera(
      NuevaCarreraEvent event, Emitter<CarreraState> emit) async {
    emit(CarreraLoading());
    final Carrera carrera = event.carrera;
    final context = event.context;
    final ref = await FirebaseFirestore.instance
        .collection('carreras')
        .add(carrera.toJson());
    emit(CarreraEnEspera(carrera));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => WaitingScreen(carreraRef: ref)));
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

  void _showModal(Carrera carrera,
      DocumentReference<Map<String, dynamic>> carreraRef) async {
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
          carreraRef: carreraRef,
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

  void _handleSnapshot(QuerySnapshot<Map<String, dynamic>> val) async {
    final ignoreList = await (context.read<UserBloc>().state as UserLogged)
        .documentReference
        .get();
    final carreras = val.docs.map((e) {
      if (!((ignoreList['carrerasIgnoradas'] as List).contains(e.id))) {
        print(e);
        return e;
      }
    });
    if (carreras.isNotEmpty && carreras.length != _carrerasCercanasCount) {
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
        if (x.aceptada) {
          return;
        }
        _carrerasCercanasCount = carreras.length;
        if (carreras.last != null) {
          _showModal(x, carreras.last!.reference);
        }
      }
    }
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
      _carrerasCercanasSubscription;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> _listenCollection() {
    final collection =
        FirebaseFirestore.instance.collection('carreras').snapshots();
    return collection.listen(_handleSnapshot, onError: (err) {
      _carrerasCercanasSubscription = _listenCollection();
    });
  }

  void _handleListen(
      ListenCarrerasEvent event, Emitter<CarreraState> emit) async {
    context = event.context;
    _carrerasCercanasSubscription = _listenCollection();
  }
}
