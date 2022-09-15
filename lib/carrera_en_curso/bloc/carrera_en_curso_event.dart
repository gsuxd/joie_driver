part of 'carrera_en_curso_bloc.dart';

abstract class CarreraEnCursoEvent extends Equatable {
  const CarreraEnCursoEvent();

  @override
  List<Object> get props => [];
}

class CargarCarreraEnCursoEvent extends CarreraEnCursoEvent {
  final DocumentReference<Map<String, dynamic>> carreraRef;
  final BuildContext context;
  const CargarCarreraEnCursoEvent(this.carreraRef, this.context);

  @override
  List<Object> get props => [carreraRef.id];
}

class CancelarCarreraEnCursoEvent extends CarreraEnCursoEvent {
  final Carrera carrera;

  const CancelarCarreraEnCursoEvent(this.carrera);

  @override
  List<Object> get props => [carrera.pasajeroId];
}
