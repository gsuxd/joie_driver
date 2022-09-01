import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../components/no_account_emprendedor.dart';
import '../../../components/social_cards.dart';
import '../../size_config.dart';
import '../../conts.dart';
import 'log_in_form.dart';
import 'package:google_sign_in/google_sign_in.dart';

class BodySign extends StatelessWidget {
  const BodySign({Key? key}) : super(key: key);

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
                  SocialCard(
                    press: () {},
                    icon: twitter,
                  ),
                  SocialCard(
                    press: () {},
                    icon: facebook,
                  ),
                  SocialCard(
                    press: signInWithGoogle,
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

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential user =  await FirebaseAuth.instance.signInWithCredential(credential);
    print(user.user?.email);

    // Once signed in, return the UserCredential
    return user;
  }

}
