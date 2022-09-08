part of 'carrera_en_curso_bloc.dart';

abstract class CarreraEnCursoState extends Equatable {
  const CarreraEnCursoState();

  @override
  List<Object> get props => [];
}

class CarreraEnCursoInitial extends CarreraEnCursoState {}

class CarreraEnCursoLoading extends CarreraEnCursoState {}

class CarreraEnCursoCancelada extends CarreraEnCursoState {
  final Carrera carrera;
  const CarreraEnCursoCancelada(this.carrera);

  @override
  List<Object> get props => [carrera.cancelada];
}

class CarreraEnCursoFinalizada extends CarreraEnCursoState {}
