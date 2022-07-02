import 'package:joiedriver/register_login_user/registro/user_data_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../components/states/states.dart';
import '../../../home_user/home.dart';
import '../../conts.dart';
import '../../error/error_screen.dart';
import '../../size_config.dart';
import '/components/default_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageNotify extends ChangeNotifier {
  Widget _image = SvgPicture.asset(document_id, height: SizeConfig.screenHeight * 0.50);

  Widget get widget => _image;

  void setImage(Widget image) {
    _image = image;
    notifyListeners();
  }
}

class ScreenNotify extends ChangeNotifier {
  bool _view = false;
  double _width = 200.0;
  double _height = 200.0;

  bool get view => _view;
  double get width => _width;
  double get height => _height;

  void setScreen(bool view, double width, double height) {
    _view = view;
    _width = width;
    _height = height;

    notifyListeners();
  }
}

final screenProvider = ChangeNotifierProvider((ref) => ScreenNotify());
final imageProvider = ChangeNotifierProvider((ref) => ImageNotify());

class Body extends ConsumerWidget {

  Widget cargando = Text("");
  RegisterUser user;
  Body(this.user);
  File? documentId;
  late ImageNotify imageView;
  @override
  Widget build(BuildContext context, watch) {
    EmailNotify  email = watch.watch(emailProvider);
    ScreenNotify  screen = watch.watch(screenProvider);
    imageView = watch.watch(imageProvider);
    CodeNotify  code = watch.watch(codeProvider);
    email.setEmail(user.email);
    print(code.value);
    code.setCode(user.code);
    print(code.value);
    return
      Stack(

        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                AppBar(
                  title: const Text('Por tu seguridad y la nuestra'),
                  centerTitle: true,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                imageView.widget,
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
                  'Toma una Foto a tu Identificación',
                  style: heading2,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                SizedBox(
                    width: SizeConfig.screenWidth * 0.6,
                    child: ButtonDef(
                        text: 'Registrar',
                        press:  () async {
                          //lleva al Home
                          if(user.documentId != null){
                            cargando = await londing();
                            screen.setScreen(true, MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
                          }
                          //Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                        })),
                const Spacer(),
              ],
            ),
          ),
                 Visibility(
                     visible: screen.view,
                     child: Container(
                   width: MediaQuery.of(context).size.width,
                   height: MediaQuery.of(context).size.height,
                   color: const  Color(0x80000000),
                 )),

                 Center(
                  child:
                    Container(
                      width: screen.width,
                      height: screen.height,
                      child: cargando
                    ))
        ],
      )
      ;
  }

  Future fases() async {
    bool fase1 = await upload();
    if(fase1){
      bool fase2 = await userRegisterData();
      if(fase2){
        bool fase3 = await userRegister();
        if(fase3){
            return true;
        }
      }
    }
    return false;
  }

  FutureBuilder londing() {
    return FutureBuilder(
      future: fases(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          if(snapshot.data){

            return HomeScreenUser();
          }else{
            return OpError(stackTrace: null,);
          }

        } else if (snapshot.hasError) {
           return OpError(stackTrace: null,);
        } else {
            return Container (
              height: 200.0,
              width: 200.0,
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width*.1,
                  right: MediaQuery.of(context).size.width*.1,
                  top: MediaQuery.of(context).size.height*.25,
                  bottom: MediaQuery.of(context).size.height*.25,
              ),
              child: CircularProgressIndicator(
                strokeWidth: 8,
              ),
            );
        }

      },
    );
  }

  Future<bool> userRegister() async {
    try{
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(email: user.email, password: user.password);
      return true;
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> userRegisterData() async {
    String addEmail = user.email;
    CollectionReference users = FirebaseFirestore.instance.collection('usersPasajeros');
    return await users.doc(addEmail)
        .set({
              'name': user.name.toUpperCase(),
              'lastname': user.lastName.toUpperCase(),
              'datebirth' : user.date,
              'gender' : user.genero.toUpperCase(),
              'phone' : user.phone,
              'address' : user.address,
              'code' : user.code,
        })
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> upload() async {
      try{
        Reference img = FirebaseStorage.instance.ref().child(user.email).child('/DocumentId.jpg');
        Reference img2 = FirebaseStorage.instance.ref().child(user.email).child('/ProfilePhoto.jpg');
        // Reference doc1 = FirebaseStorage.instance.ref().child(user.email).child('/Antecent.pdf');
        UploadTask uploadDocumentId = img.putFile(user.documentId!);
        UploadTask uploadPhotoProfile = img2.putFile(user.photoPerfil!);
        // UploadTask uploadTaskAntecedent = doc1.putFile(user.documentAntecedentes!);
        await uploadDocumentId.whenComplete((){ });
        await uploadPhotoProfile.whenComplete((){ });
        // await uploadTaskAntecedent.whenComplete((){ });
        // String url = imgUrl.ref.getDownloadURL().toString();
        return true;
      }on FirebaseAuthException catch(error){
        print(error.code);
        return false;
    }
  }

  Future getImage () async {
    ImagePicker imegaTemp = ImagePicker();
    var tempImage = await imegaTemp.pickImage(source: ImageSource.camera);
    documentId =  File(tempImage!.path);
    imageView.setImage(cambiarmage());
  }

  Widget cambiarmage(){

    if(documentId != null){
      user.documentId = documentId;
      return  Image.file(documentId!, height: SizeConfig.screenHeight * 0.50);
    }else{
      user.documentId = null;
      return SvgPicture.asset(document_id, height: SizeConfig.screenHeight * 0.50);
    }
  }
}
