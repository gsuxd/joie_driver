import 'package:joiedriver/register_login_emprendedor/registro/user_data_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../components/default_button_emprendedor.dart';
import '../../cedula/cedula.dart';
import '../../conts.dart';
import '../../size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class Body extends StatefulWidget {
  RegisterUser  user;
  Body(this.user, {Key? key}) : super(key: key);
  @override
  createState() =>  BodyE(user);
}

class BodyE extends State<Body> {
  RegisterUser user;
  BodyE(this.user);
  File? phofilePhoto;
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
            'Fotografía de tu rostro',
            style: heading2,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child: ButtonDefEmprendedor(
                  text: 'Siguiente',
                  press: () {
                    if(user.photoPerfil != null){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Cedula(user)));
                    }

                    //Navigator.pushNamed(context, PropiedadScreen.routeName);
                  })),
          const Spacer(),
        ],
      ),
    );
  }

  Future getImage () async {
    ImagePicker imegaTemp = ImagePicker();
    var tempImage = await imegaTemp.pickImage(source: ImageSource.camera);
    phofilePhoto =  File(tempImage!.path);
    setState(()  {

      imageWiew = cambiarmage();

    });
  }

  Widget cambiarmage(){

    if(phofilePhoto != null){
      user.photoPerfil = phofilePhoto;
      return  Image.file(phofilePhoto!, height: SizeConfig.screenHeight * 0.50);
    }else{
      user.photoPerfil = null;
      return SvgPicture.asset(profilePhoto, height: SizeConfig.screenHeight * 0.50);
    }
  }
}
