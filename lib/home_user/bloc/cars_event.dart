part of 'cars_bloc.dart';

abstract class CarsEvent extends Equatable {
  const CarsEvent();

  @override
  List<Object> get props => [];
}

class LoadNearCars extends CarsEvent {
  final LocationData location;
  const LoadNearCars(this.location);

  @override
  List<Object> get props => [];
}
