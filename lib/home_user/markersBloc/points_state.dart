part of 'points_bloc.dart';

abstract class PointsState extends Equatable {
  final LatLng? pointA = null;
  final LatLng? pointB = null;
  const PointsState();

  @override
  List<Object> get props => [];
}

class PointsInitial extends PointsState {}

class PointsUpdated extends PointsState {
  @override
  // ignore: overridden_fields
  final LatLng? pointA;
  @override
  // ignore: overridden_fields
  final LatLng? pointB;

  const PointsUpdated(this.pointA, this.pointB);
}
