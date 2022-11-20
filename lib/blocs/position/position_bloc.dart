import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/carrera/carrera_bloc.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:location/location.dart';

part 'position_event.dart';
part 'position_state.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  PositionBloc() : super(PositionInitial()) {
    on<GetPositionEvent>(_handleGetPosition);
  }
  void _handleGetPosition(
      GetPositionEvent event, Emitter<PositionState> emit) async {
    emit(PositionLoading());
    final Location location = Location();
    final context = event.context;
    final user = (context.read<UserBloc>().state as UserLogged).user;
    try {
      await location.requestPermission();
      await location.getLocation().then((value) {
        if (user.type == 'Conductor') {
          context.read<CarreraBloc>().add(
                ListenCarrerasEvent(
                    LatLng(
                      value.latitude!,
                      value.longitude!,
                    ),
                    context),
              );
        }
        emit(PositionObtained(value));
        return;
      });
      CollectionReference collection;
      switch (user.type) {
        case "Conductor":
          {
            collection = FirebaseFirestore.instance.collection("users");
            break;
          }
        case "Emprendedor":
          collection =
              FirebaseFirestore.instance.collection("usersEmprendedores");
          break;
        default:
          collection = FirebaseFirestore.instance.collection("usersPasajeros");
      }

      final userRef = collection.doc(user.email);
      final LocationData locationData = await location.getLocation();
      List<Placemark> placemarks = await placemarkFromCoordinates(
          locationData.latitude!, locationData.longitude!);
      var first = placemarks.first;
      await for (final value in location.onLocationChanged) {
        if (user.type == "Conductor") {
          await userRef.update({
            "location": {
              "latitude": value.latitude,
              "longitude": value.longitude
            },
            "city": first.locality,
          });
        }
        emit(PositionObtained(value));
        return;
      }
    } catch (e) {
      e;
    }
  }
}
