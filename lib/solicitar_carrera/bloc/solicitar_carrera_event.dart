part of 'solicitar_carrera_bloc.dart';

abstract class SolicitarCarreraEvent extends Equatable {
  const SolicitarCarreraEvent();

  @override
  List<Object> get props => [];
}

class SolicitarCarrera extends SolicitarCarreraEvent {
  const SolicitarCarrera(
      {required this.origen,
      required this.destino,
      required this.necesidadEspecial,
      required this.pasajeros,
      required this.precioOferta});

  final LatLng origen;
  final LatLng destino;
  final double precioOferta;
  final int pasajeros;
  final String necesidadEspecial;

  @override
  List<Object> get props =>
      [origen, destino, precioOferta, pasajeros, necesidadEspecial];
}

class CancelarCarrera extends SolicitarCarreraEvent {
  const CancelarCarrera();

  @override
  List<Object> get props => [];
}
