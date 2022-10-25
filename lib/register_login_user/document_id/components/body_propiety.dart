import 'dart:convert';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
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
  Widget _image =
      SvgPicture.asset(cedularImg, height: SizeConfig.screenHeight * 0.50);

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

class Body extends ConsumerStatefulWidget {
  RegisterUser user;

  Body({Key? key, required this.user}) : super(key: key);
  @override
  _Body createState() => _Body(this.user);
}

class _Body extends ConsumerState<Body> {
  EncryptedSharedPreferences encryptedSharedPreferences =
      EncryptedSharedPreferences();
  void _getIsReanuding() async {
    final prefs = await encryptedSharedPreferences.getInstance();
    if (prefs.getBool("isFailLogin") != null) {
      setState(() {
        _isReanuding = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getIsReanuding();
    imageView = cambiarmage();
    setState(() {});
  }

  bool _isReanuding = false;
  Widget? cargando;
  RegisterUser user;
  _Body(this.user);
  File? cedulaR;
  late Widget imageView;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              if (!_isReanuding) imageView,
              if (!_isReanuding)
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
              if (!_isReanuding)
                SizedBox(
                  width: SizeConfig.screenWidth * 0.2,
                  height: SizeConfig.screenHeight * 0.1,
                  child: IconButton(
                    onPressed: getImage,
                    icon: SvgPicture.asset(camara),
                  ),
                ),
              if (!_isReanuding)
                Text(
                  'Fotografía Trasera de tu Cédula',
                  style: heading2,
                  textAlign: TextAlign.center,
                ),
              const Spacer(),
              SizedBox(
                  width: SizeConfig.screenWidth * 0.6,
                  child: ButtonDef(
                      text: 'Registrar',
                      press: () async {
                        //lleva al Home
                        if (_isReanuding) {
                          setState(() {
                            cargando = londing();
                          });
                        } else {
                          if (user.cedulaR != null) {
                            setState(() {
                              cargando = londing();
                            });
                          }
                        }
                      })),
              const Spacer(),
            ],
          ),
        ),
        Visibility(
            visible: cargando != null,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: const Color(0x80000000),
              child: Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: cargando)),
            )),
      ],
    );
  }

  Future fases() async {
    bool fase1 = await userRegister();
    final _prefs = await EncryptedSharedPreferences().getInstance();
    if (fase1) {
      bool fase2 = await userRegisterData();
      if (fase2) {
        bool fase3 = await upload();
        if (fase3) {
          _prefs.remove("userRegister");
          _prefs.remove("locationRegister");
          _prefs.remove("userType");
          context
              .read<UserBloc>()
              .add(LoginUserEvent(user.email, user.password, context));
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
          if (snapshot.data) {
            return const HomeScreenUser();
          } else {
            return const OpError(
              stackTrace: null,
            );
          }
        } else if (snapshot.hasError) {
          return const OpError(
            stackTrace: null,
          );
        } else {
          return Container(
            height: 200.0,
            width: 200.0,
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * .1,
              right: MediaQuery.of(context).size.width * .1,
              top: MediaQuery.of(context).size.height * .25,
              bottom: MediaQuery.of(context).size.height * .25,
            ),
            child: const CircularProgressIndicator(
              strokeWidth: 8,
            ),
          );
        }
      },
    );
  }

  Future<bool> userRegister() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      await encryptedSharedPreferences.setString('email', user.email);
      await encryptedSharedPreferences.setString('passwd', user.password);
      await encryptedSharedPreferences.setString('typeuser', "pasajero");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {}
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> userRegisterData() async {
    String addEmail = user.email;
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersPasajeros');
    return await users
        .doc(addEmail)
        .set({
          'name': user.name.toUpperCase(),
          'lastname': user.lastName.toUpperCase(),
          'datebirth': user.date,
          'gender': user.genero.toUpperCase(),
          'phone': user.phone,
          'address': user.address,
          'code': user.code,
          'date_register': DateTime.now(),
        })
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> upload() async {
    if (_isReanuding) {
      return true;
    } else {
      try {
        Reference img = FirebaseStorage.instance
            .ref()
            .child(user.email)
            .child('/Cedula.jpg');
        Reference img1 = FirebaseStorage.instance
            .ref()
            .child(user.email)
            .child('/CedulaR.jpg');
        Reference img2 = FirebaseStorage.instance
            .ref()
            .child(user.email)
            .child('/ProfilePhoto.jpg');
        // Reference doc1 = FirebaseStorage.instance.ref().child(user.email).child('/Antecent.pdf');
        UploadTask uploadCedula = img.putFile(user.documentId!);
        UploadTask uploadCedulaR = img1.putFile(user.cedulaR!);
        UploadTask uploadPhotoProfile = img2.putFile(user.photoPerfil!);
        // UploadTask uploadTaskAntecedent = doc1.putFile(user.documentAntecedentes!);
        await uploadCedula.whenComplete(() {});
        await uploadCedulaR.whenComplete(() {});
        await uploadPhotoProfile.whenComplete(() {});

        user.photoPerfil?.delete(recursive: true);
        user.documentAntecedentes?.delete(recursive: true);
        user.cedulaR?.delete(recursive: true);
        user.documentId?.delete(recursive: true);
        return true;
      } on FirebaseAuthException catch (error) {
        return false;
      }
    }
  }

  Future getImage() async {
    final _prefs = await EncryptedSharedPreferences().getInstance();
    _prefs.setString("userRegister", jsonEncode(user.toJson()));
    _prefs.setString("locationRegister", "cedulaPhotoR");
    ImagePicker imegaTemp = ImagePicker();
    var tempImage = await imegaTemp.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      maxHeight: 1000,
    );
    cedulaR = File(tempImage!.path);
    imageView = cambiarmage();
    setState(() {});
  }

  Widget cambiarmage() {
    if (cedulaR != null) {
      user.cedulaR = cedulaR;
      return Image.file(cedulaR!, height: SizeConfig.screenHeight * 0.50);
    } else {
      if (user.cedulaR != null) {
        return Image.file(user.cedulaR!,
            height: SizeConfig.screenHeight * 0.50);
      } else {
        user.cedulaR = null;
        return SvgPicture.asset(cedularImg,
            height: SizeConfig.screenHeight * 0.50);
      }
    }
  }
}
