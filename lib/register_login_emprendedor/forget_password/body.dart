import 'package:flutter/material.dart';
import '../../components/no_account_chofer.dart';
import '../size_config.dart';

import 'form_password.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.04),
          child: Column(
            children: [
              Text("Olvide mi contraseña",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getPropertieScreenWidth(18))),
              Text(
                "Por favor, ingresa tu correo \ny te enviaremos un código de verificación. ",
                style: TextStyle(fontSize: getPropertieScreenWidth(14)),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
              const ForgotFormPassword(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
              const NoAccountChofer(),
            ],
          ),
        ),
      ),
    );
  }
}
