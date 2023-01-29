import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:joiedriver/helpers/generate_random_string.dart';
import 'package:joiedriver/metodos_pago/models/metodo_pago.dart';
import 'package:joiedriver/register_login_chofer/registro/user_data_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../components/default_button_chofer.dart';
import '../../../components/states/states.dart';
import '../../../home/home.dart';
import '../../conts.dart';
import '../../error/error_screen.dart';
import '../../size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageNotify extends ChangeNotifier {
  Widget _image =
      SvgPicture.asset(carnetPropiedad, height: SizeConfig.screenHeight * 0.50);

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
  final RegisterUser user;

  const Body({Key? key, required this.user}) : super(key: key);
  @override
  _Body createState() => _Body();
}

class _Body extends ConsumerState<Body> {
  @override
  void initState() {
    super.initState();
    final value = ref.read(screenProvider);
    value.setScreen(false, 200, 200);
  }

  Widget cargando = const Text("");
  File? imagePropiedad;
  late ImageNotify imageView;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        EmailNotify email = ref.watch(emailProvider);
        ScreenNotify screen = ref.watch(screenProvider);
        imageView = ref.watch(imageProvider);
        CodeNotify code = ref.watch(codeProvider);
        email.setEmail(widget.user.email);
        code.setCode(widget.user.code);
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
                    'Toma una foto de tu Vehículo',
                    style: heading2,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  SizedBox(
                      width: SizeConfig.screenWidth * 0.6,
                      child: ButtonDefChofer(
                          text: 'Registrar',
                          press: () async {
                            //lleva al Home
                            if (widget.user.documentVehicle != null) {
                              cargando = londing();
                              screen.setScreen(
                                  true,
                                  MediaQuery.of(context).size.width,
                                  MediaQuery.of(context).size.height);
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
                  color: const Color(0x80000000),
                )),
            Center(
                child: SizedBox(
                    width: screen.width,
                    height: screen.height,
                    child: cargando))
          ],
        );
      },
    );
  }

  Future fases() async {
    bool fase1 = await userRegister();
    if (fase1) {
      bool fase2 = await userRegisterData();
      if (fase2) {
        bool fase3 = await upload();
        if (fase3) {
          context.read<UserBloc>().add(
              LoginUserEvent(widget.user.email, widget.user.password, context));
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
            return const HomeScreen();
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
          email: widget.user.email, password: widget.user.password);
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
    String addEmail = widget.user.email;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return await users
        .doc(addEmail)
        .set({
          'name': widget.user.name.toUpperCase(),
          'lastname': widget.user.lastName.toUpperCase(),
          'datebirth': widget.user.date,
          'gender': widget.user.genero.toUpperCase(),
          'phone': widget.user.phone,
          'address': widget.user.address,
          'parent': widget.user.referenceCode,
          'code': generateRandomString(10),
          'metodoPago': MetodoPago.fromJson({
            'nameComplete': widget.user.nameComplete,
            'number_bank': widget.user.numberBank,
            'number_ci': widget.user.numberCi,
            'type_bank': widget.user.typeBank,
            'bank': widget.user.bank,
            'date_ci': widget.user.dateCi,
          }).toJson(),
          'vehicle': {
            'default': {
              'year': 0,
              'capacity': 0,
              'color': '',
              'brand': widget.user.marca,
              'plate': widget.user.placa.toUpperCase(),
            }
          }
        })
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> upload() async {
    try {
      Reference img = FirebaseStorage.instance
          .ref()
          .child(widget.user.email)
          .child('/Vehicle.jpg');
      Reference img2 = FirebaseStorage.instance
          .ref()
          .child(widget.user.email)
          .child('/TarjetaPropiedad.jpg');
      Reference img3 = FirebaseStorage.instance
          .ref()
          .child(widget.user.email)
          .child('/ProfilePhoto.jpg');
      Reference img4 = FirebaseStorage.instance
          .ref()
          .child(widget.user.email)
          .child('/Cedula.jpg');
      Reference img5 = FirebaseStorage.instance
          .ref()
          .child(widget.user.email)
          .child('/CedulaR.jpg');
      Reference img6 = FirebaseStorage.instance
          .ref()
          .child(widget.user.email)
          .child('/Licencia.jpg');

      UploadTask uploadTaskCartaPropiedad =
          img.putFile(widget.user.documentVehicle!);
      UploadTask uploadTaskTarjetaPropiedad =
          img2.putFile(widget.user.documentTarjetaPropiedad!);
      UploadTask uploadTaskProfilePhoto =
          img3.putFile(widget.user.photoPerfil!);
      UploadTask uploadTaskCedula = img4.putFile(widget.user.cedula!);
      UploadTask uploadTaskCedulaR = img5.putFile(widget.user.cedulaR!);
      UploadTask uploadTaskLicencia = img6.putFile(widget.user.licencia!);

      if (widget.user.documentAntecedentes != null) {
        Reference doc1 = FirebaseStorage.instance
            .ref()
            .child(widget.user.email)
            .child('/Antecent.pdf');
        UploadTask uploadTaskAntecedent =
            doc1.putFile(widget.user.documentAntecedentes!);
        await uploadTaskAntecedent.whenComplete(() {});
      }

      await uploadTaskCartaPropiedad.whenComplete(() {});
      await uploadTaskTarjetaPropiedad.whenComplete(() {});
      await uploadTaskProfilePhoto.whenComplete(() {});
      await uploadTaskCedula.whenComplete(() {});
      await uploadTaskCedulaR.whenComplete(() {});
      await uploadTaskLicencia.whenComplete(() {});

      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  Future getImage() async {
    ImagePicker imegaTemp = ImagePicker();
    var tempImage = await imegaTemp.pickImage(source: ImageSource.camera);
    imagePropiedad = File(tempImage!.path);
    imageView.setImage(cambiarmage());
  }

  Widget cambiarmage() {
    if (imagePropiedad != null) {
      widget.user.documentVehicle = imagePropiedad;
      return Image.file(imagePropiedad!,
          height: SizeConfig.screenHeight * 0.50);
    } else {
      widget.user.documentVehicle = null;
      return SvgPicture.asset(carnetPropiedad,
          height: SizeConfig.screenHeight * 0.50);
    }
  }
}
