import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:joiedriver/helpers/calculate_distance.dart';

part 'cars_event.dart';
part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  CarsBloc() : super(CarsInitial()) {
    on<LoadNearCars>(_handleLoad);
  }

  void _handleLoad(LoadNearCars event, Emitter<CarsState> emit) async {
    final docs = FirebaseFirestore.instance.collection("users").snapshots();
    final List<Marker> cars = [];
    await for (var element in docs) {
      for (final x in element.docs) {
        final data = x.data();
        if (data['active'] == null) {
          continue;
        }
        final distance = calculateDistance(
            LatLng(
              event.location.latitude,
              event.location.longitude,
            ),
            LatLng(
                data["location"]["latitude"], data["location"]["longitude"]));
        if (distance > 60) {
          emit(
            CarsLoaded(cars),
          );
          continue;
        }
        if (cars
                .firstWhere((element) => element.markerId.value == x.id,
                    orElse: () => const Marker(markerId: MarkerId("null")))
                .markerId
                .value ==
            "null") {
          if (data["active"]) {
            cars.add(
              Marker(
                markerId: MarkerId(x.id),
                icon: await BitmapDescriptor.fromAssetImage(
                    const ImageConfiguration(size: Size(12, 12)),
                    "assets/images/coches-en-el-mapa.png"),
                position: LatLng(
                  data["location"]["latitude"],
                  data["location"]["longitude"],
                ),
              ),
            );
          }
        } else if (data['active']) {
          cars.removeWhere((element) => element.markerId.value == x.id);
        }
        emit(CarsLoaded(cars));
      }
    }
  }
}
