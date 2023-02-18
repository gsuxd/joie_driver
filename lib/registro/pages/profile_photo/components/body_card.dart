import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:joiedriver/camera/bloc/camera_bloc.dart';
import 'package:joiedriver/camera/camera_preview.dart';
import 'package:joiedriver/registro/bloc/registro_data.dart';
import '../../../../components/default_button_chofer.dart';
import '../../../../conts.dart';
import '../../../../size_config.dart';
import 'dart:io';

import '../../../bloc/registro_bloc.dart';
import '../../cedula/cedula.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "profilePhoto";
  }

  @override
  createState() => BodyE();
}

class BodyE extends State<Body> {
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
              'Fotografía de tu rostro',
              style: heading2,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.03,
            ),
            CameraView(
                condition: data?.photoPerfil,
                onSuccess: (picture) async {
                  try {
                    data?.photoPerfil = File(picture.path);
                    context.read<RegistroBloc>().add(NextScreenRegistroEvent(
                        context, const Cedula(), data!));
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
            SizedBox(
              height: SizeConfig.screenHeight * 0.05,
            ),
            const Spacer(),
            if (data?.photoPerfil != null)
              SizedBox(
                  width: SizeConfig.screenWidth * 0.6,
                  child: ButtonDefChofer(
                      text: 'Siguiente',
                      press: () {
                        //Navigator.pushNamed(context, PropiedadScreen.routeName);
                      })),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
