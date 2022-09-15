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

class CarreraEnCursoChofer extends CarreraEnCursoState {
  final DocumentReference<Map<String, dynamic>> carreraRef;
  final Carrera carrera;

  const CarreraEnCursoChofer({required this.carreraRef, required this.carrera});

  @override
  List<Object> get props => [carreraRef.id];
}

class CarreraEnCursoFinalizada extends CarreraEnCursoState {}
