import 'package:joiedriver/register_login_chofer/registro/user_data_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../components/default_button_chofer.dart';
import '../../../register_login_chofer/Antecedents/antecedentes.dart';
import '../../conts.dart';
import '../../size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class Body extends StatefulWidget {
  RegisterUser  user;
  Body(this.user, {Key? key}) : super(key: key);
  @override
  createState() =>  _Body(user);
}

class _Body extends State<Body> {
  RegisterUser user;
  _Body(this.user);
  File? licencia;
  late Widget imageWiew ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageWiew = cambiarmage();
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
              onPressed: getImage,
              icon: SvgPicture.asset(camara),
            ),
          ),
          Text(
            'Fotografía tu Licencia de Conducir',
            style: heading2,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child: ButtonDefChofer(
                  text: 'Siguiente',
                  press: () {
                    if(user.licencia != null){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AntecedentsScreen(user)));
                    }
                  })),
          const Spacer(),
        ],
      ),
    );
  }

  Future getImage () async {
    ImagePicker imegaTemp = ImagePicker();
    var tempImage = await imegaTemp.pickImage(source: ImageSource.camera, imageQuality: 70);
    licencia =  File(tempImage!.path);
    setState(()  {

      imageWiew = cambiarmage();

    });
  }

  Widget cambiarmage(){

    if(licencia != null){
      user.licencia = licencia;
      return  Image.file(licencia!, height: SizeConfig.screenHeight * 0.50);
    }else{
      user.licencia = null;
      return SvgPicture.asset(licenciaImg, height: SizeConfig.screenHeight * 0.50);
    }
  }
}
