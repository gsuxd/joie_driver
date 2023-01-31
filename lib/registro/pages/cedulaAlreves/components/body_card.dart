import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joiedriver/components/default_button_emprendedor.dart';
import 'package:joiedriver/conts.dart';
import 'package:joiedriver/registro/bloc/registro_data.dart';
import 'package:joiedriver/registro/bloc/registro_enums.dart';
import 'dart:io';

import 'package:joiedriver/size_config.dart';

import '../../../bloc/registro_bloc.dart';
import '../../licencia/licencia.dart';
import '../../loading/loading_page.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  createState() => _Body();
}

class _Body extends State<Body> {
  File? cedulaR;
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
            'Fotografía Trasera de tu Cédula',
            style: heading2,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child: ButtonDefEmprendedor(
                  text: 'Siguiente',
                  press: () {
                    if (data?.cedulaR != null) {
                      Widget page;
                      switch (data?.type) {
                        case UserType.chofer:
                          page = const Licencia();
                          break;
                        case UserType.emprendedor:
                          page = const Licencia();
                          break;
                        default:
                          page = const LoadingPage();
                      }
                      context
                          .read<RegistroBloc>()
                          .add(NextScreenRegistroEvent(context, page, data!));
                    }
                  })),
          const Spacer(),
        ],
      ),
    );
  }

  Future getImage() async {
    ImagePicker imegaTemp = ImagePicker();
    var tempImage = await imegaTemp.pickImage(source: ImageSource.camera);
    cedulaR = File(tempImage!.path);
    setState(() {
      imageWiew = cambiarmage();
    });
  }

  Widget cambiarmage() {
    if (cedulaR != null) {
      data?.cedulaR = cedulaR;
      return Image.file(cedulaR!, height: SizeConfig.screenHeight * 0.50);
    } else {
      data?.cedulaR = null;
      return SvgPicture.asset(cedularImg,
          height: SizeConfig.screenHeight * 0.50);
    }
  }
}
