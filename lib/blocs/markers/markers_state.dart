part of 'markers_bloc.dart';

abstract class MarkersState extends Equatable {
  const MarkersState();

  @override
  List<Object> get props => [];
}

class MarkersInitial extends MarkersState {
  final List<Marker> markers = [];
}

class MarkersUpdated extends MarkersState {
  final List<Marker> markers;

  const MarkersUpdated(this.markers);

  @override
  List<Object> get props => [markers.length];
}
