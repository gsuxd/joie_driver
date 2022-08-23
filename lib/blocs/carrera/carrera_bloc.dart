import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'carrera_model.dart';

part 'carrera_event.dart';
part 'carrera_state.dart';

class CarreraBloc extends Bloc<CarreraEvent, CarreraState> {
  CarreraBloc() : super(CarreraInitial()) {
    on<CarreraEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
