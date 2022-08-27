import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:joiedriver/colors.dart';
import 'package:joiedriver/helpers/calculate_distance.dart';

import 'carrera_model.dart';

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
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: blue,
                        width: 4,
                      ),
                    ),
                    height: 255,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            carrera.inicio.latitude, carrera.inicio.longitude),
                        zoom: distance < 5
                            ? distance < 3
                                ? 15
                                : 14
                            : 12,
                      ),
                      polylines: {
                        Polyline(
                          polylineId: const PolylineId("road"),
                          color: Colors.red,
                          points: polypoints.points
                              .map((e) => LatLng(e.latitude, e.longitude))
                              .toList(),
                        ),
                      },
                      markers: {
                        Marker(
                            markerId: const MarkerId('inicio'),
                            position: carrera.inicio,
                            infoWindow: InfoWindow(
                                title: 'Inicio',
                                snippet:
                                    "${calculateDistance(LatLng(location.latitude!, location.longitude!), carrera.inicio).toStringAsFixed(2)}KM")),
                        Marker(
                          markerId: const MarkerId('actual'),
                          position: LatLng(
                            location.latitude!,
                            location.longitude!,
                          ),
                          icon: choferIcon,
                        ),
                        Marker(
                            markerId: const MarkerId('fin'),
                            position: carrera.destino,
                            infoWindow: InfoWindow(
                                title: 'Destino',
                                snippet:
                                    "${calculateDistance(LatLng(location.latitude!, location.longitude!), carrera.destino).toStringAsFixed(2)}KM")),
                      },
                    ),
                  ),
                  Row(children: [
                    const CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 10,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Centro'),
                          Text('Las Margaritas')
                        ])
                  ]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Número de pasajeros: ${carrera.numeroPasajeros}'),
                      Text('Necesidad especial: ${carrera.condicionEspecial}'),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    overlayColor:
                        MaterialStateColor.resolveWith((states) => blue),
                    child: const Text('Aceptar por 50.000 \$'),
                  ),
                  Text('Forma de pago ${carrera.metodoPago}'),
                ],
              ),
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
