part of 'registro_bloc.dart';

abstract class RegistroState extends Equatable {
  const RegistroState();

  @override
  List<Object> get props => [];
}

class RegistroInitial extends RegistroState {}

class ResumeRegistroState extends RegistroState {
  final RegistroData userData;
  const ResumeRegistroState(this.userData);
}

class UpdateRegistroState extends RegistroState {
  final RegistroData userData;
  const UpdateRegistroState(this.userData);
}

class LoadingRegistroState extends RegistroState {
  final String message;
  const LoadingRegistroState(this.message);

  @override
  List<Object> get props => [message];
}

class ErrorRegistroState extends RegistroState {
  final String message;
  const ErrorRegistroState(this.message);

  @override
  List<Object> get props => [message];
}
