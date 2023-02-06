import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/components/default_button_emprendedor.dart';
import 'package:joiedriver/conts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:joiedriver/registro/bloc/registro_bloc.dart';
import 'package:joiedriver/registro/bloc/registro_data.dart';
import 'package:joiedriver/registro/pages/foto_vehiculo/foto_vehiculo.dart';
import 'package:joiedriver/registro/pages/tarjeta_propiedad/carta_propiedad.dart';
import 'package:joiedriver/size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  createState() => _Body();
}

class _Body extends State<Body> {
  File? tarjetaPropiedad;
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
            'Tomale una foto a tu tarjeta de propiedad',
            style: heading2,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child: ButtonDefEmprendedor(
                  text: 'Siguiente',
                  press: () {
                    if (data?.registroDataVehiculo?.documentTarjetaPropiedad !=
                        null) {
                      context.read<RegistroBloc>().add(NextScreenRegistroEvent(
                          context, const FotoVehiculo(), data!));
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
    tarjetaPropiedad = File(tempImage!.path);
    setState(() {
      imageWiew = cambiarmage();
    });
  }

  Widget cambiarmage() {
    if (tarjetaPropiedad != null) {
      data?.registroDataVehiculo?.documentTarjetaPropiedad = tarjetaPropiedad;
      return Image.file(tarjetaPropiedad!,
          height: SizeConfig.screenHeight * 0.50);
    } else {
      data?.registroDataVehiculo?.documentTarjetaPropiedad = null;
      return SvgPicture.asset(fotoCarnet,
          height: SizeConfig.screenHeight * 0.50);
    }
  }
}
