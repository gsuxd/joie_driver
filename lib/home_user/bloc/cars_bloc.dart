import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'cars_event.dart';
part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  CarsBloc() : super(CarsInitial()) {
    on<LoadNearCars>(_handleLoad);
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void _handleLoad(LoadNearCars event, Emitter<CarsState> emit) async {
    final List<Stream<DocumentSnapshot<Map<String, dynamic>>>> futures = [];
    final docs = await FirebaseFirestore.instance
        .collection("users")
        .where("active", isEqualTo: true)
        .get();
    if (docs.docs.isEmpty) {
      emit(const CarsLoaded(<Marker>[]));
      return;
    }
    for (var element in docs.docs) {
      futures.add(element.reference.snapshots());
    }
    final List<Marker> cars = [];
    for (var element in futures) {
      await for (final x in element) {
        cars.add(
          Marker(
              markerId: MarkerId(x.id),
              icon: await BitmapDescriptor.fromAssetImage(
                  const ImageConfiguration(size: Size(12, 12)),
                  "assets/images/coches-en-el-mapa.png"),
              position: LatLng(x.data()!["location"]["latitude"],
                  x.data()!["location"]["longitude"])),
        );
        emit(CarsLoaded(cars));
      }
    }
  }
}
