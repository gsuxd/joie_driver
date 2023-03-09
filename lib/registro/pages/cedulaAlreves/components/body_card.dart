import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/camera/bloc/camera_bloc.dart';
import 'package:joiedriver/camera/camera_preview.dart';
import 'package:joiedriver/conts.dart';
import 'package:joiedriver/registro/bloc/registro_data.dart';
import 'package:joiedriver/blocs/user/user_enums.dart';
import 'dart:io';

import 'package:joiedriver/size_config.dart';

import '../../../bloc/registro_bloc.dart';
import '../../licencia/licencia.dart';
import '../../loading/loading_page.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "cedulaR";
  }

  @override
  createState() => _Body();
}

class _Body extends State<Body> {
  @override
  void initState() {
    super.initState();
    data =
        ((context.read<RegistroBloc>()).state as UpdateRegistroState).userData;
  }

  RegistroData? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraBloc()..add(InitializeCameraEvent()),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.007,
            ),
            Text(
              'Fotografía Trasera de tu Cédula',
              style: heading2,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.03,
            ),
            CameraView(
                condition: data?.cedulaR,
                onSuccess: (picture) async {
                  try {
                    data?.cedulaR = File(picture.path);
                    Widget page;
                    switch (data?.type) {
                      case UserType.chofer:
                        page = const Licencia();
                        break;
                      default:
                        page = const LoadingPage();
                    }
                    context
                        .read<RegistroBloc>()
                        .add(NextScreenRegistroEvent(context, page, data!));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString(),
                        ),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
