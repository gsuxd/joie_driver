import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:joiedriver/blocs/carrera/carrera_listener.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:joiedriver/carrera_en_curso/bloc/carrera_en_curso_bloc.dart';
import 'package:joiedriver/carrera_en_curso/carrera_en_curso_chofer.dart';
import 'package:joiedriver/home/home.dart';
import 'package:joiedriver/main.dart';
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
    final service = GetIt.I.get<FlutterBackgroundService>();
    _isRunnin = true;
    _tripsListener = service.on('newTrip').listen((message) {
      CarreraListener.showModal(Carrera.fromJson(message!["carrera"]),
          FirebaseFirestore.instance.doc(message["reference"]), context);
    });
    _tripsListener = service.on('tripError').listen((message) {
      message;
      _isRunnin = false;
      _handleListen(event, emit);
    });
    _ofertadosListener = service.on('tripAccepted').listen((message) {
      MyApp.navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => CarreraEnCursoBloc(),
            child: CarreraEnCursoPage(
              carreraRef: FirebaseFirestore.instance.doc(message!['reference']),
              carrera: Carrera.fromJson(message['carrera']),
            ),
          ),
        ),
      );
    });
  }

  StreamSubscription<Map<String, dynamic>?>? _tripsListener;
  StreamSubscription<Map<String, dynamic>?>? _errorListener;
  StreamSubscription<Map<String, dynamic>?>? _ofertadosListener;
  bool _isRunnin = false;
  late BuildContext context;

  @override
  Future<void> close() async {
    for (var element in _carrerasOfertada) {
      element['subscription'].cancel();
    }
    _tripsListener?.cancel();
    _errorListener?.cancel();
    _ofertadosListener?.cancel();
    return super.close();
  }

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

  final List<Map<String, dynamic>> _carrerasOfertada = [];

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
