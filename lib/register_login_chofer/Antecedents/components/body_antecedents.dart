import 'dart:convert';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:joiedriver/register_login_chofer/registro/conductor_data_register.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../conts.dart';
import '../../size_config.dart';
import '../../tarjeta_propiedad/card_propierty.dart';
import '/components/default_button_chofer.dart';
import 'dart:io';

class Body extends StatefulWidget {
  RegisterConductor user;
  Body(this.user, {Key? key}) : super(key: key);
  @override
  createState() => _Body(this.user);
}

class _Body extends State<Body> {
  RegisterConductor user;
  _Body(this.user);
  File? FileAntecedentes;
  late Widget imageWiew;
  bool varInit = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageWiew = cambiarfile();
  }

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
              child: ButtonDefChofer(
                  text: 'Siguiente',
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CardPropierty(user)));
                  })),
          const Spacer(),
        ],
      ),
    );
  }

  Future getFile() async {
    final _prefs = await EncryptedSharedPreferences().getInstance();
    _prefs.setString("userRegister", jsonEncode(user.toJson()));
    _prefs.setString("locationRegister", "antecedentsFile");
    var tempFile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      'pdf',
    ]);
    FileAntecedentes = File(tempFile!.paths[0].toString());
    setState(() {
      imageWiew = cambiarfile();
    });
  }

  Widget cambiarfile() {
    if (FileAntecedentes != null) {
      user.documentAntecedentes = FileAntecedentes;
      return Center(
          child: Text(
        FileAntecedentes!.path.split('/').last,
        style: const TextStyle(fontWeight: FontWeight.bold, color: blue),
        textAlign: TextAlign.center,
      ));
    } else {
      if (user.documentAntecedentes != null) {
        return Center(
            child: Text(
          user.documentAntecedentes!.path.split('/').last,
          style: const TextStyle(fontWeight: FontWeight.bold, color: blue),
          textAlign: TextAlign.center,
        ));
      } else {
        user.documentAntecedentes = null;
        return SvgPicture.asset(antePen,
            height: SizeConfig.screenHeight * 0.50);
      }
    }
  }
}
