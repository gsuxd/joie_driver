import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'points_event.dart';
part 'points_state.dart';

class PointsBloc extends Bloc<PointsEvent, PointsState> {
  PointsBloc() : super(PointsInitial()) {
    on<UpdatePoints>(_handleUpdate);
  }
  void _handleUpdate(UpdatePoints event, Emitter<PointsState> emit) {
    emit(PointsUpdated(event.pointA, event.pointB));
  }
}
