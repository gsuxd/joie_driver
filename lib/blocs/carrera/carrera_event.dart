part of 'carrera_bloc.dart';

abstract class CarreraEvent extends Equatable {
  const CarreraEvent();

  @override
  List<Object> get props => [];
}

class ListenCarrerasEvent extends CarreraEvent {
  final BuildContext context;
  const ListenCarrerasEvent(this.context);
}

class NuevaCarreraEvent extends CarreraEvent {
  final Carrera carrera;
  final BuildContext context;

  const NuevaCarreraEvent(this.carrera, this.context);

  @override
  List<Object> get props => [carrera.inicio];
}

class AceptarOfertaEvent extends CarreraEvent {
  final DocumentReference<Map<String, dynamic>> carreraRef;
  final String choferId;
  final BuildContext context;

  const AceptarOfertaEvent(this.carreraRef, this.choferId, this.context);

  @override
  List<Object> get props => [carreraRef.id];
}

class CancelarCarreraEvent extends CarreraEvent {
  final String carreraId;

  const CancelarCarreraEvent(this.carreraId);

  @override
  List<Object> get props => [carreraId];
}

class OfertarCarreraEvent extends CarreraEvent {
  final DocumentReference<Map<String, dynamic>> carreraRef;
  final String? precioOferta;
  final int tardanza;
  const OfertarCarreraEvent(this.carreraRef, this.precioOferta, this.tardanza);

  @override
  List<Object> get props => [carreraRef.id];
}
