part of 'points_bloc.dart';

abstract class PointsEvent extends Equatable {
  const PointsEvent();

  @override
  List<Object> get props => [];
}

class UpdatePoints extends PointsEvent {
  final LatLng? pointA;
  final LatLng? pointB;
  const UpdatePoints(this.pointA, this.pointB);

  @override
  List<Object> get props => [];
}
