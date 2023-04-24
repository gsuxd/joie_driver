import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/colors.dart';

import 'bloc/camera_bloc.dart';

///Widget for viewing a live preview of camera
///This widget works with a [CameraBloc] in his Parent
///The [onSuccess] param is called when a picture is Accepted by the user
class CameraView extends StatefulWidget {
  const CameraView({Key? key, required this.onSuccess, this.condition})
      : super(key: key);
  final void Function(XFile) onSuccess;
  final File? condition;
  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  FlashMode _flashMode = FlashMode.auto;

  @override
  void initState() {
    super.initState();
    if (widget.condition != null) {
      context
          .read<CameraBloc>()
          .add(RecoveredPictureCameraEvent(widget.condition!.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraBloc, CameraState>(
      builder: (context, state) {
        return Column(children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: blue, width: 10),
                borderRadius: BorderRadius.circular(10)),
            child: state is LoadingCameraState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state is InitializedCameraState
                    ? CameraPreview(
                        state.controller,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () async {
                                  switch (_flashMode) {
                                    case (FlashMode.auto):
                                      {
                                        setState(() {
                                          _flashMode = FlashMode.always;
                                        });
                                        break;
                                      }
                                    case (FlashMode.always):
                                      {
                                        setState(() {
                                          _flashMode = FlashMode.torch;
                                        });
                                        break;
                                      }
                                    case (FlashMode.torch):
                                      {
                                        setState(() {
                                          _flashMode = FlashMode.off;
                                        });
                                        break;
                                      }
                                    default:
                                      setState(() {
                                        _flashMode = FlashMode.auto;
                                      });
                                  }

                                  await state.controller
                                      .setFlashMode(_flashMode);
                                },
                                icon: Icon(
                                  _flashMode == FlashMode.auto
                                      ? Icons.flash_auto
                                      : _flashMode == FlashMode.always
                                          ? Icons.flash_on
                                          : _flashMode == FlashMode.torch
                                              ? Icons.flashlight_on
                                              : Icons.flash_off,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: IconButton(
                                  onPressed: () {
                                    context
                                        .read<CameraBloc>()
                                        .add(ChangeCameraEvent());
                                  },
                                  icon: const Icon(
                                    Icons.switch_camera_outlined,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                      )
                    : state is PictureTakedCameraState
                        ? Center(
                            child: Image.file(File(state.picture.path)),
                          )
                        : state is CameraErrorState
                            ? Center(
                                child: Text(
                                  state.message,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              )
                            : Center(
                                child: Text(
                                  'Unknown State',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
            width: state is PictureTakedCameraState ? 280 : 290,
            height: state is PictureTakedCameraState ? null : 400,
          ),
          const SizedBox(height: 10),
          if (state is InitializedCameraState)
            ElevatedButton.icon(
              onPressed: () {
                context.read<CameraBloc>().add(TakePictureCameraEvent());
              },
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text("Tomar foto"),
            ),
          if (state is PictureTakedCameraState) ...[
            ElevatedButton.icon(
                onPressed: () {
                  widget.onSuccess(state.picture);
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text("Aceptar")),
            ElevatedButton.icon(
                onPressed: () {
                  context.read<CameraBloc>().add(RegretPictureCameraEvent());
                },
                icon: const Icon(Icons.cancel_outlined),
                label: const Text("Rechazar")),
          ],
        ]);
      },
    );
  }
}
