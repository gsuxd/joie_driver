import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
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
  Widget _image = SvgPicture.asset(antePen, height: SizeConfig.screenHeight * 0.50);

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
  EncryptedSharedPreferences encryptedSharedPreferences = EncryptedSharedPreferences();
  @override
  void initState() {
    super.initState();
    final value = ref.read(screenProvider);
    value.setScreen(false, 200, 200);
  }
  Widget cargando = const Text("");
  RegisterUser user;
  _Body(this.user);
  File? antecedentes;
  late ImageNotify imageView;



  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        EmailNotify  email = ref.watch(emailProvider);
        ScreenNotify  screen = ref.watch(screenProvider);
        imageView = ref.watch(imageProvider);
        CodeNotify  code = ref.watch(codeProvider);
        email.setEmail(user.email);
        code.setCode(user.code);
        return Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  AppBar(
                    title: const Text('Por tu seguridad y la nuestra'),
                    centerTitle: true,
                    leading:
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios, color: jBase, size: 24,)
                      ),
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
                          press:  () async {
                            //lleva al Home
                              cargando = londing();
                              screen.setScreen(true, MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
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
                SizedBox(
                    width: screen.width,
                    height: screen.height,
                    child: cargando
                ))
          ],
        );
      },
    );
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
          if(snapshot.data){
            return HomeScreen(user.code);
          }else{
            return const OpError(stackTrace: null,);
          }
        } else if (snapshot.hasError) {
          return const OpError(stackTrace: null,);
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
            child: const CircularProgressIndicator(
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
      await encryptedSharedPreferences.setString('code', user.code);
      await encryptedSharedPreferences.setString('email', user.email);
      await encryptedSharedPreferences.setString('passwd', user.password);
      await encryptedSharedPreferences.setString('typeuser', "emprendedor");
      return true;
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {

      } else if (e.code == 'email-already-in-use') {
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> userRegisterData() async {
    String addEmail = user.email;
    CollectionReference users = FirebaseFirestore.instance.collection('usersEmprendedor');
    return await users.doc(addEmail)
        .set({
      'name': user.name.toUpperCase(),
      'lastname': user.lastName.toUpperCase(),
      'datebirth' : user.date,
      'gender' : user.genero.toUpperCase(),
      'phone' : user.phone,
      'address' : user.address,
      'city' : user.city,
      'parent' : user.referenceCode,
      'code' : user.code,
      'nameComplete' : user.nameComplete,
      'number_bank' : user.numberBank,
      'number_ci' : user.numberCi,
      'type_bank' : user.typeBank,
      'bank' : user.bank,
      'date_ci' : user.dateCi,
    })
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> upload() async {
    try{

      Reference img3 = FirebaseStorage.instance.ref().child(user.email).child('/ProfilePhoto.jpg');
      Reference img4 = FirebaseStorage.instance.ref().child(user.email).child('/Cedula.jpg');
      Reference img5 = FirebaseStorage.instance.ref().child(user.email).child('/CedulaR.jpg');

      UploadTask uploadTaskProfilePhoto = img3.putFile(user.photoPerfil!);
      UploadTask uploadTaskCedula = img4.putFile(user.cedula!);
      UploadTask uploadTaskCedulaR = img5.putFile(user.cedulaR!);

      if(user.documentAntecedentes != null){
        Reference doc1 = FirebaseStorage.instance.ref().child(user.email).child('/Antecent.pdf');
        UploadTask uploadTaskAntecedent = doc1.putFile(user.documentAntecedentes!);
        await uploadTaskAntecedent.whenComplete((){ });
      }

      await uploadTaskProfilePhoto.whenComplete((){ });
      await uploadTaskCedula.whenComplete((){ });
      await uploadTaskCedulaR.whenComplete((){ });
      return true;
    }on FirebaseAuthException catch(error){
      return false;
    }
  }

  Future getImage () async {
    var tempFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf',]);
    antecedentes = File(tempFile!.paths[0].toString());
    imageView.setImage(cambiarmage());
  }

  Widget cambiarmage(){

    if(antecedentes != null){
      user.documentAntecedentes = antecedentes;
      return  Center(
          child: Text(antecedentes!.path.split('/').last, style: const TextStyle(fontWeight: FontWeight.bold, color: blue), textAlign: TextAlign.center,)
      );
    }else{
      user.documentAntecedentes = null;
      return SvgPicture.asset(antePen, height: SizeConfig.screenHeight * 0.50);
    }
  }
}