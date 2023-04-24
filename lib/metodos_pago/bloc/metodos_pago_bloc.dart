import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:joiedriver/singletons/user_data.dart';
import 'package:meta/meta.dart';

import '../models/metodo_pago.dart';

part 'metodos_pago_event.dart';
part 'metodos_pago_state.dart';

class MetodoPagoBloc extends Bloc<MetodoPagoEvent, MetodoPagoState> {
  MetodoPagoBloc() : super(MetodoPagoInitial()) {
    on<LoadMetodoPagoEvent>(_handleLoadMetodoPagoEvent);
    on<AddMetodoPagoEvent>(_handleAddMetodoPagoEvent);
  }

  Future<void> _handleAddMetodoPagoEvent(
      AddMetodoPagoEvent event, Emitter<MetodoPagoState> emit) async {
    emit(MetodoPagoLoading());
    try {
      final userData = GetIt.I<UserData>();
      final metodoPago = event.metodoPago;
      final data = await FirebaseFirestore.instance
          .collection("users")
          .doc(userData.email)
          .get();
      data.reference.update({'metodoPago': metodoPago.toJson()});
      emit(MetodoPagoLoaded(MetodoPago.fromJson(data.data()!)));
    } catch (e) {
      emit(MetodoPagoInitial());
    }
  }

  Future<void> _handleLoadMetodoPagoEvent(
      LoadMetodoPagoEvent event, Emitter<MetodoPagoState> emit) async {
    emit(MetodoPagoLoading());
    final UserData user = GetIt.I.get<UserData>();
    final metodoPago = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.email)
        .get()
        .then((value) {
      return value.data()?["metodoPago"];
    });
    try {
      emit(MetodoPagoLoaded(MetodoPago.fromJson(metodoPago)));
    } catch (e) {
      emit(MetodoPagoInitial());
    }
  }
}
