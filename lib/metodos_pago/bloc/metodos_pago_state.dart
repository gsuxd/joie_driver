part of 'metodos_pago_bloc.dart';

@immutable
abstract class MetodoPagoState {}

class MetodoPagoInitial extends MetodoPagoState {}

class MetodoPagoLoading extends MetodoPagoState {}

class MetodoPagoLoaded extends MetodoPagoState {
  final MetodoPago metodoPago;

  MetodoPagoLoaded(this.metodoPago);
}
