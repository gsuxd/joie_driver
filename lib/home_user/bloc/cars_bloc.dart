import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/helpers/calculate_distance.dart';
import 'package:location/location.dart';

part 'cars_event.dart';
part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  CarsBloc() : super(CarsInitial()) {
    on<LoadNearCars>(_handleLoad);
  }

  void _handleLoad(LoadNearCars event, Emitter<CarsState> emit) async {
    final List<Stream<DocumentSnapshot<Map<String, dynamic>>>> futures = [];
    final docs = await FirebaseFirestore.instance
        .collection("users")
        .where("active", isEqualTo: true)
        .get();
    if (docs.docs.isEmpty) {
      emit(
        const CarsLoaded(<Marker>[]),
      );
      return;
    }
    for (var element in docs.docs) {
      futures.add(
        element.reference.snapshots(),
      );
    }
    final List<Marker> cars = [];
    for (var element in futures) {
      await for (final x in element) {
        final data = x.data();
        final distance = calculateDistance(
            LatLng(
              event.location.latitude!,
              event.location.longitude!,
            ),
            LatLng(
                data!["location"]["latitude"], data["location"]["longitude"]));
        if (distance > 60) {
          emit(
            CarsLoaded(cars),
          );
          continue;
        }
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
        emit(CarsLoaded(cars));
      }
    }
  }
}
