import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:joiedriver/helpers/generate_random_string.dart';
import 'package:joiedriver/metodos_pago/models/metodo_pago.dart';
import 'package:joiedriver/register_login_emprendedor/registro/user_data_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../components/default_button_emprendedor.dart';
import '../../../components/states/states.dart';
import '../../../home/home.dart';
import '../../conts.dart';
import '../../error/error_screen.dart';
import '../../size_config.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageNotify extends ChangeNotifier {
  Widget _image =
      SvgPicture.asset(antePen, height: SizeConfig.screenHeight * 0.50);

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
  File? antecedentes;
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
                    leading: Container(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: jBase,
                            size: 24,
                          )),
                    ),
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
                      icon: SvgPicture.asset(adjun),
                    ),
                  ),
                  Text(
                    'Antecedentes Penales (Opcional)',
                    style: heading2,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  SizedBox(
                      width: SizeConfig.screenWidth * 0.6,
                      child: ButtonDefEmprendedor(
                          text: 'Registrar',
                          press: () async {
                            //lleva al Home
                            cargando = londing();
                            screen.setScreen(
                                true,
                                MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height);
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
          context
              .read<UserBloc>()
              .add(LoginUserEvent(email!, password!, context));
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
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersEmprendedor');
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
          }).toJson()
        })
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> upload() async {
    try {
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

      UploadTask uploadTaskProfilePhoto =
          img3.putFile(widget.user.photoPerfil!);
      UploadTask uploadTaskCedula = img4.putFile(widget.user.cedula!);
      UploadTask uploadTaskCedulaR = img5.putFile(widget.user.cedulaR!);

      if (widget.user.documentAntecedentes != null) {
        Reference doc1 = FirebaseStorage.instance
            .ref()
            .child(widget.user.email)
            .child('/Antecent.pdf');
        UploadTask uploadTaskAntecedent =
            doc1.putFile(widget.user.documentAntecedentes!);
        await uploadTaskAntecedent.whenComplete(() {});
      }

      await uploadTaskProfilePhoto.whenComplete(() {});
      await uploadTaskCedula.whenComplete(() {});
      await uploadTaskCedulaR.whenComplete(() {});
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  Future getImage() async {
    var tempFile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      'pdf',
    ]);
    antecedentes = File(tempFile!.paths[0].toString());
    imageView.setImage(cambiarmage());
  }

  Widget cambiarmage() {
    if (antecedentes != null) {
      widget.user.documentAntecedentes = antecedentes;
      return Center(
          child: Text(
        antecedentes!.path.split('/').last,
        style: const TextStyle(fontWeight: FontWeight.bold, color: blue),
        textAlign: TextAlign.center,
      ));
    } else {
      widget.user.documentAntecedentes = null;
      return SvgPicture.asset(antePen, height: SizeConfig.screenHeight * 0.50);
    }
  }
}
