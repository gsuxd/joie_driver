import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/camera/camera_preview.dart';
import 'package:joiedriver/conts.dart';
import 'package:flutter/material.dart';
import 'package:joiedriver/registro/bloc/registro_bloc.dart';
import 'package:joiedriver/registro/bloc/registro_data.dart';
import 'package:joiedriver/registro/pages/antecedentes/antecedentes.dart';
import 'package:joiedriver/size_config.dart';
import 'dart:io';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
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
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.007,
          ),
          Text(
            'Toma una foto de tu Vehículo',
            style: heading2,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.03,
          ),
          CameraView(
              condition: data?.registroDataVehiculo?.documentVehicle,
              onSuccess: (file) async {
                data?.registroDataVehiculo?.documentVehicle = File(file.path);
                context.read<RegistroBloc>().add(NextScreenRegistroEvent(
                    context, const Antecedentes(), data!));
              }),
        ],
      ),
    );
  }
}
