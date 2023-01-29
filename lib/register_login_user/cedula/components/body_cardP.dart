import 'package:joiedriver/register_login_user/registro/user_data_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../components/default_button.dart';
import '../../conts.dart';
import '../../document_id/document_id.dart';
import '../../size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Body extends StatefulWidget {
  final RegisterUser user;
  const Body(this.user, {Key? key}) : super(key: key);
  @override
  createState() => _Body();
}

class _Body extends State<Body> {
  File? cedula;
  late Widget imageWiew;
  @override
  void initState() {
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
            'Fotografía Frontal de tu Cédula',
            style: heading2,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child: ButtonDef(
                  text: 'Siguiente',
                  press: () {
                    if (widget.user.documentId != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DocumentId(widget.user)));
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
    cedula = File(tempImage!.path);
    setState(() {
      imageWiew = cambiarmage();
    });
  }

  Widget cambiarmage() {
    if (cedula != null) {
      widget.user.documentId = cedula;
      return Image.file(cedula!, height: SizeConfig.screenHeight * 0.50);
    } else {
      widget.user.documentId = null;
      return SvgPicture.asset(cedulaImg,
          height: SizeConfig.screenHeight * 0.50);
    }
  }
}
