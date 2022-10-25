part of 'metodos_pago_bloc.dart';

@immutable
abstract class MetodoPagoEvent {}

class LoadMetodoPagoEvent extends MetodoPagoEvent {}

class AddMetodoPagoEvent extends MetodoPagoEvent {
  final MetodoPago metodoPago;

  AddMetodoPagoEvent(this.metodoPago);
}

class RemoveMetodoPagoEvent extends MetodoPagoEvent {
  final MetodoPago metodoPago;

  RemoveMetodoPagoEvent(this.metodoPago);
}
