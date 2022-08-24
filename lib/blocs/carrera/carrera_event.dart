part of 'carrera_bloc.dart';

abstract class CarreraEvent extends Equatable {
  const CarreraEvent();

  @override
  List<Object> get props => [];
}

class ListenCarrerasEvent extends CarreraEvent {
  final LatLng location;
  const ListenCarrerasEvent(this.location);

  @override
  List<Object> get props => [location.latitude, location.longitude];
}

class NuevaCarreraEvent extends CarreraEvent {
  final Carrera carrera;

  const NuevaCarreraEvent(this.carrera);

  @override
  List<Object> get props => [carrera.inicio];
}

class AceptarCarreraEvent extends CarreraEvent {
  final String carreraId;

  const AceptarCarreraEvent(this.carreraId);

  @override
  List<Object> get props => [carreraId];
}

class CancelarCarreraEvent extends CarreraEvent {
  final String carreraId;

  const CancelarCarreraEvent(this.carreraId);

  @override
  List<Object> get props => [carreraId];
}

class OfertarCarreraEvent extends CarreraEvent {
  final String carreraId;
  final String? precioOferta;

  const OfertarCarreraEvent(this.carreraId, this.precioOferta);

  @override
  List<Object> get props => [carreraId];
}

class ComenzarCarreraEvent extends CarreraEvent {
  final String carreraId;

  const ComenzarCarreraEvent(this.carreraId);

  @override
  List<Object> get props => [carreraId];
}
