import 'dart:async';
import 'dart:isolate';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:joiedriver/blocs/carrera/carrera_listener.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:joiedriver/carrera_en_curso/bloc/carrera_en_curso_bloc.dart';
import 'package:joiedriver/carrera_en_curso/carrera_en_curso_chofer.dart';
import 'package:joiedriver/home/home.dart';
import 'package:joiedriver/solicitar_carrera/pages/waiting_screen.dart';
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
    if (_isRunnin) return;
    context = event.context;
    final ReceivePort port = ReceivePort("Listening trips");
    final isolate = await FlutterIsolate.spawn(
        CarreraListener.handleListen, [port.sendPort]);
    _isRunnin = true;
    await for (final message in port.asBroadcastStream()) {
      if (message["error"] != null) {
        _isRunnin = false;
        isolate.kill(priority: Isolate.immediate);
        return;
      }
      CarreraListener.showModal(
          Carrera.fromJson(message["carrera"]), message["reference"], context);
    }
  }

  bool _isRunnin = false;
  late BuildContext context;
  CarreraListener? _carreraListener;

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
    if (_carreraListener?.carrerasCercanasSubscription != null) {
      _carreraListener?.carrerasCercanasSubscription!.cancel();
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
}
