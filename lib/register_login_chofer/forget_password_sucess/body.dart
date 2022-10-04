import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../components/default_button.dart';
import '../sign_in/log_in.dart';
import '../size_config.dart';

class BodySucessChofer extends StatelessWidget {
  const BodySucessChofer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.04),
          child: ListView(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.05,
              ),
              Text("Hemos Enviado Un link para que restablezcas tu contraseña", textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getPropertieScreenWidth(18))),
              const SizedBox(
                height: 10,
              ),
              Text("Si no encuentras el email revisa tu bandeja de correo no deseado o spam", textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: getPropertieScreenWidth(16))),

              SizedBox(
                height: SizeConfig.screenHeight * 0.05,
              ),
              SvgPicture.asset("assets/images/password_recovery.svg", width: MediaQuery.of(context).size.width - 40,),

              SizedBox(
                height: SizeConfig.screenHeight * 0.06,
              ),
              ButtonDef(
                text: 'Iniciar Sesión',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LognInScreen()));
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
