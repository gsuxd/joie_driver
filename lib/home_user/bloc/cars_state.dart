part of 'cars_bloc.dart';

abstract class CarsState extends Equatable {
  const CarsState();

  @override
  List<Object> get props => [];
}

class CarsInitial extends CarsState {}

class CarsLoading extends CarsState {}

class CarsLoaded extends CarsState {
  final List<Marker> cars;

  const CarsLoaded(this.cars);

  @override
  List<Object> get props => [cars.length];
}
