part of 'markers_bloc.dart';

abstract class MarkersEvent extends Equatable {
  const MarkersEvent();

  @override
  List<Object> get props => [];
}

class NewMarker extends MarkersEvent {
  final Marker marker;

  const NewMarker(this.marker);

  @override
  List<Object> get props => [marker.markerId.value];
}

class CleanupAllMarkers extends MarkersEvent {
  @override
  List<Object> get props => [];
}
