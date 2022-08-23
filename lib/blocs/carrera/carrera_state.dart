part of 'carrera_bloc.dart';

abstract class CarreraState extends Equatable {
  const CarreraState();

  @override
  List<Object> get props => [];
}

class CarreraInitial extends CarreraState {}

class CarreraEnEspera extends CarreraState {}

class CarreraAceptada extends CarreraState {}

class CarreraEnCurso extends CarreraState {}

class CarreraCancelada extends CarreraState {}

class NuevaCarrera extends CarreraState {
  final Carrera carrera;

  const NuevaCarrera(this.carrera);

  @override
  List<Object> get props => [carrera];
}
