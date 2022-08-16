import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joiedriver/singletons/user_data.dart';
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
    try {
      await location
          .getLocation()
          .then((value) => emit(PositionObtained(value)));
      CollectionReference collection;
      switch (event.user.type) {
        case "chofer":
          {
            collection = FirebaseFirestore.instance.collection("users");
            break;
          }
        case "usersEmprendedores":
          collection =
              FirebaseFirestore.instance.collection("usersEmprendedores");
          break;
        default:
          collection = FirebaseFirestore.instance.collection("usersPasajeros");
      }

      final userRef = collection.doc(event.user.email);
      await for (final value in location.onLocationChanged) {
        await userRef.update({
          "location": {"latitude": value.latitude, "longitude": value.longitude}
        });
        emit(PositionObtained(value));
      }
    } catch (e) {
      print(e);
    }
  }
}
