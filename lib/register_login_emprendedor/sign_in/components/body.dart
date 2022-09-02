import 'package:archive/archive.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../components/no_account_emprendedor.dart';
import '../../../components/social_cards.dart';
import '../../app_screens/ganancias/ganancias.dart';
import '../../size_config.dart';
import '../../conts.dart';
import 'log_in_form.dart';
import 'package:google_sign_in/google_sign_in.dart';

class BodySign extends StatelessWidget {
   BodySign({Key? key}) : super(key: key);
  EncryptedSharedPreferences encryptedSharedPreferences = EncryptedSharedPreferences();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.01,
              ),
              SvgPicture.asset(
                logo,
                width: getPropertieScreenWidth(120),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              
              Text(
                'Indica tu correo y contraseña \nO inicia sesión con tus redes sociales.',
                style: TextStyle(
                  fontSize: getPropertieScreenWidth(15),
                  fontWeight: FontWeight.w400,
                  color: jtextColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getPropertieScreenWidth(20)),
                child: const SignInForm(),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SocialCard(
                  //   press: () {},
                  //   icon: twitter,
                  // ),
                  // SocialCard(
                  //   press: () {},
                  //   icon: facebook,
                  // ),
                  SocialCard(
                    press: () async {
                      Future<bool> login =   signInWithGoogle(context);
                      bool loginGoogle = false;
                      await login.then((value) => loginGoogle = value);
                      if(loginGoogle){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              //builder: (context) =>  HomeScreen(hash.hash.toString())));
                                builder: (context) =>  const Ganancias()));
                      }else{
                        showToast("Error al Iniciar Sesión con Google");
                      }
                    },
                    icon: google,
                  ),
                ],
              ),
              const NoAccountEmprendedor(),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: Colors.transparent,
            title: const Text('Iniciando  Sesión'),
            content: SizedBox(
              width: 200.0,
              height: 200.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            )));
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );


    UserCredential user =  await FirebaseAuth.instance.signInWithCredential(credential);
    print(user.user?.email);
    if(user.user != null ){
      Iterable<String>? binarys = user.user?.email.toString().codeUnits.map((int strInt) => strInt.toRadixString(2));
      Crc32 hash =  Crc32();
      for (var i in binarys!) {
        hash.add([int.parse(i)]);
      }
      String? _email = user.user?.email.toString();
      await encryptedSharedPreferences.setString('code', hash.hash.toString());
      await encryptedSharedPreferences.setString('email', _email! );
      await encryptedSharedPreferences.setString('typeuser', "emprendedor");
      await encryptedSharedPreferences.setString('google', "true");
      return true;
    }
    return false;
  }

}
