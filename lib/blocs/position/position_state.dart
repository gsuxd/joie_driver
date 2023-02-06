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

class PositionGetted {
  final double latitude;
  final double longitude;
  const PositionGetted(this.latitude, this.longitude);
}

class PositionObtained extends PositionState {
  final PositionGetted location;

  const PositionObtained(this.location);

  @override
  List<Object> get props => [location.latitude, location.latitude];
}
