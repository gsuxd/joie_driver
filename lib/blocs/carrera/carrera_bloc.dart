import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:joiedriver/home/home.dart';
import 'package:joiedriver/solicitar_carrera/pages/waiting_screen.dart';
import 'carrera_listener.dart';
import 'carrera_model.dart';

part 'carrera_event.dart';
part 'carrera_state.dart';

class CarreraBloc extends Bloc<CarreraEvent, CarreraState> {
  CarreraBloc() : super(CarreraInitial()) {
    on<ListenCarrerasEvent>(_handleListen);
    on<NuevaCarreraEvent>(_handleNuevaCarrera);
    on<OfertarCarreraEvent>(_handleOfertarCarrera);
    on<AceptarOfertaEvent>(_handleAceptarOferta);
  }

  void _handleListen(
      ListenCarrerasEvent event, Emitter<CarreraState> emit) async {
    context = event.context;
    FirebaseMessaging.onMessage.listen((event) {
      CarreraListener.showModal(Carrera.fromJson(event.data["carrera"]),
          FirebaseFirestore.instance.doc(event.data["ref"]), context);
    });
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
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      e;
    }
    emit(CarreraInitial());
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
}
