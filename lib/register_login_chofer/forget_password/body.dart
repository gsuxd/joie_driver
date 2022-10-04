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
        child: ListView(

            children: [
              Image.asset("assets/images/puppy_forget.jpg", width: MediaQuery.of(context).size.width,),
              const SizedBox(
                height: 10.0,
              ),
              Padding(padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.04),
              child: Column(
                children: [
                  Text(
                    "Por favor, ingresa tu correo \ny te enviaremos un link de recuperación ",
                    style: TextStyle(fontSize: getPropertieScreenWidth(14)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.05,
                  ),
                  const ForgotFormPassword(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.05,
                  ),
                  const NoAccountChofer(),
                ],
              ),)

            ],
          ),
      ),
    );
  }
}
