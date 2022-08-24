import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
      print('emitir carrera');
    }
  }

  final DocumentReference<Map<String, dynamic>> user = FirebaseFirestore
      .instance
      .collection('usersPasajeros')
      .doc(FirebaseAuth.instance.currentUser!.email);

  void _handleListen(
      ListenCarrerasEvent event, Emitter<CarreraState> emit) async {
    final userCollection = user.snapshots();
    userCollection.listen(_handleSnapshot);
  }
}
