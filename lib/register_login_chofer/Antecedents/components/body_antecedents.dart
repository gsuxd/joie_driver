import 'package:joiedriver/register_login_chofer/registro/user_data_register.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../conts.dart';
import '../../size_config.dart';
import '../../tarjeta_propiedad/card_propierty.dart';
import '/components/default_button.dart';
import 'dart:io';
class Body extends StatefulWidget {
  RegisterUser user;
  Body( RegisterUser this.user);
  @override
  createState() =>  _Body(this.user);
}


class _Body extends State<Body> {
  RegisterUser user;
  _Body( RegisterUser this.user);
  File? FileAntecedentes;
  late Widget imageWiew ;
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
                    if(user.documentAntecedentes != null){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CardPropierty(user)));
                    }

                  })),
          const Spacer(),
        ],
      ),
    );
  }



  Future getFile () async {

    var tempFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf',]);
    FileAntecedentes = File(tempFile!.paths[0].toString());
    setState(() {
      imageWiew = cambiarfile();
    });

  }



  Widget cambiarfile(){

    if(FileAntecedentes != null ){
      user.documentAntecedentes = FileAntecedentes;
      return  Center(
          child: Text(FileAntecedentes!.path.split('/').last, style: TextStyle(fontWeight: FontWeight.bold, color: blue), textAlign: TextAlign.center,)
      );
    }else{
      user.documentAntecedentes = null;
      return SvgPicture.asset(antePen, height: SizeConfig.screenHeight * 0.50);
    }
  }
}
