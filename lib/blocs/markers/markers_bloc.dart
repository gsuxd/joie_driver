import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'markers_event.dart';
part 'markers_state.dart';

class MarkersBloc extends Bloc<MarkersEvent, MarkersState> {
  MarkersBloc() : super(MarkersInitial()) {
    on<NewMarker>(_addMarker);
    on<CleanupAllMarkers>(_cleanupAllMarkers);
  }

  void _addMarker(NewMarker event, Emitter<MarkersState> emit) {
    emit(MarkersUpdated((state as dynamic).markers + [event.marker]));
  }

  void _cleanupAllMarkers(CleanupAllMarkers event, Emitter<MarkersState> emit) {
    emit(const MarkersUpdated([]));
  }
}
