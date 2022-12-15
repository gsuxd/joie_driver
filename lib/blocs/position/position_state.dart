part of 'position_bloc.dart';

abstract class PositionState extends Equatable {
  const PositionState();

  @override
  List<Object> get props => [];
}

class PositionInitial extends PositionState {}

class PositionLoading extends PositionState {}

class PositionError extends PositionState {
  final String message;

  const PositionError(this.message);
}

class PositionObtained extends PositionState {
  final LocationData location;

  const PositionObtained(this.location);

  @override
  List<Object> get props => [location.latitude!, location.latitude!];
}
