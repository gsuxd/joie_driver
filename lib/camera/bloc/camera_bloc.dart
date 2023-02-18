import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitial()) {
    on<InitializeCameraEvent>(_handleInitialize);
    on<TakePictureCameraEvent>(_handleTakePicture);
    on<RegretPictureCameraEvent>(_handleRegret);
    on<ChangeCameraEvent>(_handleChangeCamera);
    on<RecoveredPictureCameraEvent>(_handleRecover);
  }
  CameraController? controller;
  @override
  Future<void> close() {
    controller?.dispose();
    return super.close();
  }

  CameraLensDirection _direction = CameraLensDirection.back;

  void _handleRecover(
      RecoveredPictureCameraEvent event, Emitter<CameraState> emit) async {
    if (event.path.isEmpty) {
      return;
    }
    final XFile picture = XFile(event.path);
    emit(PictureTakedCameraState(picture));
  }

  void _handleChangeCamera(
      ChangeCameraEvent event, Emitter<CameraState> emit) async {
    emit(LoadingCameraState());
    final _cameras = await availableCameras();
    switch (_direction) {
      case CameraLensDirection.back:
        _direction = CameraLensDirection.front;
        break;
      default:
        _direction = CameraLensDirection.back;
    }
    controller = CameraController(
        _cameras.where((element) => element.lensDirection == _direction).first,
        ResolutionPreset.veryHigh);
    await controller?.initialize().then((val) {
      emit(InitializedCameraState(controller!));
      return val;
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            emit(const CameraErrorState(
                'Acceso denegado, porfavor brinda acceso a la cámara'));
            break;
          default:
            emit(const CameraErrorState('Error desconocido'));
            break;
        }
      }
    });
  }

  void _handleRegret(
      RegretPictureCameraEvent event, Emitter<CameraState> emit) {
    emit(InitializedCameraState(controller!));
  }

  void _handleTakePicture(
      TakePictureCameraEvent event, Emitter<CameraState> emit) async {
    try {
      controller?.setFlashMode(FlashMode.off);
      final picture = await controller!.takePicture();
      emit(PictureTakedCameraState(picture));
    } catch (e) {
      emit(CameraErrorState(e.toString()));
    }
  }

  void _handleInitialize(
      InitializeCameraEvent event, Emitter<CameraState> emit) async {
    emit(LoadingCameraState());
    final _cameras = await availableCameras();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    await controller?.initialize().then((val) {
      emit(InitializedCameraState(controller!));
      return val;
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            emit(const CameraErrorState(
                'Acceso denegado, porfavor brinda acceso a la cámara'));
            break;
          default:
            emit(const CameraErrorState('Error desconocido'));
            break;
        }
      }
    });
  }
}
