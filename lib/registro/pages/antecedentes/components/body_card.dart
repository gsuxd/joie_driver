import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/camera/bloc/camera_bloc.dart';
import 'package:joiedriver/camera/camera_preview.dart';
import 'package:joiedriver/components/default_button.dart';
import 'package:joiedriver/conts.dart';
import 'package:flutter/material.dart';
import 'package:joiedriver/registro/bloc/registro_bloc.dart';
import 'package:joiedriver/registro/bloc/registro_data.dart';
import 'package:joiedriver/size_config.dart';
import 'dart:io';

import '../../loading/loading_page.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  createState() => _Body();
}

class _Body extends State<Body> {
  File? fileAntecedentes;
  bool varInit = true;
  late Widget imageWiew;
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
              height: SizeConfig.screenHeight * 0.03,
            ),
            Text(
              'Adjunta tus antescedentes Penales (Opcional)',
              style: heading2,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.05,
            ),
            CameraView(
                condition: data?.documentAntecedentes,
                onSuccess: (file) async {
                  data?.documentAntecedentes = File(file.path);
                  context.read<RegistroBloc>().add(NextScreenRegistroEvent(
                      context, const LoadingPage(), data!));
                }),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              width: 200,
              child: ButtonDef(
                  text: 'Siguiente',
                  press: () {
                    context.read<RegistroBloc>().add(NextScreenRegistroEvent(
                        context, const LoadingPage(), data!));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
