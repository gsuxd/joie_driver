part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class InitializedCameraState extends CameraState {
  final CameraController controller;
  const InitializedCameraState(this.controller);
}

class LoadingCameraState extends CameraState {}

class PictureTakedCameraState extends CameraState {
  final XFile picture;
  const PictureTakedCameraState(this.picture);
}

class CameraErrorState extends CameraState {
  final String message;
  const CameraErrorState(this.message);
  @override
  List<Object> get props => [message];
}
