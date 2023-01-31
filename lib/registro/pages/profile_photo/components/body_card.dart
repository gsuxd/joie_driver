import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:joiedriver/registro/bloc/registro_data.dart';
import '../../../../components/default_button_chofer.dart';
import '../../../../conts.dart';
import '../../../../size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../bloc/registro_bloc.dart';
import '../../cedula/cedula.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  createState() => BodyE();
}

class BodyE extends State<Body> {
  File? phofilePhoto;
  late Widget imageWiew;
  @override
  void initState() {
    super.initState();
    data =
        ((context.read<RegistroBloc>()).state as UpdateRegistroState).userData;
    imageWiew = cambiarmage();
  }

  RegistroData? data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          imageWiew,
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          SizedBox(
            width: SizeConfig.screenWidth * 0.2,
            height: SizeConfig.screenHeight * 0.1,
            child: IconButton(
              onPressed: getImage,
              icon: SvgPicture.asset(camara),
            ),
          ),
          Text(
            'Fotografía de tu rostro',
            style: heading2,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child: ButtonDefChofer(
                  text: 'Siguiente',
                  press: () {
                    if (data?.photoPerfil != null) {
                      context.read<RegistroBloc>().add(NextScreenRegistroEvent(
                          context, const Cedula(), data!));
                    }

                    //Navigator.pushNamed(context, PropiedadScreen.routeName);
                  })),
          const Spacer(),
        ],
      ),
    );
  }

  Future getImage() async {
    ImagePicker imegaTemp = ImagePicker();
    var tempImage = await imegaTemp.pickImage(source: ImageSource.camera);
    phofilePhoto = File(tempImage!.path);
    setState(() {
      imageWiew = cambiarmage();
    });
  }

  Widget cambiarmage() {
    if (phofilePhoto != null) {
      data?.photoPerfil = phofilePhoto;
      return Image.file(phofilePhoto!, height: SizeConfig.screenHeight * 0.50);
    } else {
      data?.photoPerfil = null;
      return SvgPicture.asset(profilePhoto,
          height: SizeConfig.screenHeight * 0.50);
    }
  }
}
