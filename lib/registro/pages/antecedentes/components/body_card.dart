import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/components/default_button_emprendedor.dart';
import 'package:joiedriver/conts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:joiedriver/registro/bloc/registro_bloc.dart';
import 'package:joiedriver/registro/bloc/registro_data.dart';
import 'package:joiedriver/registro/bloc/registro_enums.dart';
import 'package:joiedriver/registro/pages/loading/loading_page.dart';
import 'package:joiedriver/size_config.dart';
import 'dart:io';

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
    imageWiew = cambiarfile();
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
              onPressed: getFile,
              icon: SvgPicture.asset(adjun),
            ),
          ),
          Text(
            'Adjunta tus antescedentes Penales (Opcional)',
            style: heading2,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child: ButtonDefEmprendedor(
                  text: 'Siguiente',
                  press: () {
                    //if (data?.type != UserType.chofer ||
                    //    data?.documentAntecedentes != null) {
                    context.read<RegistroBloc>().add(NextScreenRegistroEvent(
                        context, const LoadingPage(), data!));
                    //}
                  })),
          const Spacer(),
        ],
      ),
    );
  }

  Future getFile() async {
    var tempFile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      'pdf',
    ]);
    fileAntecedentes = File(tempFile!.paths[0].toString());
    setState(() {
      imageWiew = cambiarfile();
    });
  }

  Widget cambiarfile() {
    if (fileAntecedentes != null) {
      data?.documentAntecedentes = fileAntecedentes;
      return Center(
          child: Text(
        fileAntecedentes!.path.split('/').last,
        style: const TextStyle(fontWeight: FontWeight.bold, color: blue),
        textAlign: TextAlign.center,
      ));
    } else {
      data?.documentAntecedentes = null;
      return SvgPicture.asset(antePen, height: SizeConfig.screenHeight * 0.50);
    }
  }
}
