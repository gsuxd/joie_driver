import 'package:joiedriver/register_login_user/registro/user_data_register.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../conts.dart';
import '../../size_config.dart';
import '../../profile_photo/profile_photo.dart';
import '/components/default_button.dart';
import 'dart:io';

class Body extends StatefulWidget {
  final RegisterUser user;
  const Body(this.user, {Key? key}) : super(key: key);
  @override
  createState() => _Body();
}

class _Body extends State<Body> {
  File? FileAntecedentes;
  late Widget imageWiew;
  bool varInit = true;
  @override
  void initState() {
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
            'Adjunta tus antescedentes penales',
            style: heading2,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child: ButtonDef(
                  text: 'Siguiente',
                  press: () {
                    //Navigator.pushNamed(context, CardPropierty.routeName);
                    if (widget.user.documentAntecedentes != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePhoto(widget.user)));
                    }
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
    FileAntecedentes = File(tempFile!.paths[0].toString());
    setState(() {
      imageWiew = cambiarfile();
    });
  }

  Widget cambiarfile() {
    if (FileAntecedentes != null) {
      widget.user.documentAntecedentes = FileAntecedentes;
      return Center(
          child: Text(
        FileAntecedentes!.path.split('/').last,
        style: const TextStyle(fontWeight: FontWeight.bold, color: blue),
        textAlign: TextAlign.center,
      ));
    } else {
      widget.user.documentAntecedentes = null;
      return SvgPicture.asset(antePen, height: SizeConfig.screenHeight * 0.50);
    }
  }
}
