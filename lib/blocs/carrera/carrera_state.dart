part of 'carrera_bloc.dart';

abstract class CarreraState extends Equatable {
  const CarreraState();

  @override
  List<Object> get props => [];
}

class CarreraInitial extends CarreraState {}

class CarreraLoading extends CarreraState {}

class CarreraEnEspera extends CarreraState {
  final Carrera carrera;

  const CarreraEnEspera(this.carrera);

  @override
  List<Object> get props => [carrera.inicio];
}

class CarreraAceptada extends CarreraState {}

class CarreraEnCurso extends CarreraState {
  final DocumentReference<Map<String, dynamic>> carreraRef;
  final Carrera carrera;

  const CarreraEnCurso(this.carreraRef, this.carrera);

  @override
  List<Object> get props => [carrera.inicio];
}

class CarreraCancelada extends CarreraState {}

class NuevaCarrera extends CarreraState {
  final Carrera carrera;

  const NuevaCarrera(this.carrera);

  @override
  List<Object> get props => [carrera];
}
