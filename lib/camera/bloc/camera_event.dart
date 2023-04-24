part of 'camera_bloc.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object> get props => [];
}

class InitializeCameraEvent extends CameraEvent {}

class TakePictureCameraEvent extends CameraEvent {}

class RegretPictureCameraEvent extends CameraEvent {}

class AcceptPictureCameraEvent extends CameraEvent {}

class ChangeCameraEvent extends CameraEvent {}

class RecoveredPictureCameraEvent extends CameraEvent {
  final String path;
  const RecoveredPictureCameraEvent(this.path);
}
