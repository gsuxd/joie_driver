part of 'carrera_en_curso_bloc.dart';

abstract class CarreraEnCursoEvent extends Equatable {
  const CarreraEnCursoEvent();

  @override
  List<Object> get props => [];
}

class CargarCarreraEnCursoEvent extends CarreraEnCursoEvent {
  final String idPasajero;
  final BuildContext context;
  const CargarCarreraEnCursoEvent(this.idPasajero, this.context);

  @override
  List<Object> get props => [idPasajero];
}

class CancelarCarreraEnCursoEvent extends CarreraEnCursoEvent {
  final Carrera carrera;

  const CancelarCarreraEnCursoEvent(this.carrera);

  @override
  List<Object> get props => [carrera.pasajeroId];
}
