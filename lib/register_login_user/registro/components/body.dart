import 'package:flutter/material.dart';
import '../../../components/social_cards_user.dart';
import '../../conts.dart';
import '../../size_config.dart';
import 'registro_form.dart';

class Body extends StatelessWidget {
   Body({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ListView(
          padding: EdgeInsets.symmetric(horizontal: getPropertieScreenHeight(20)),
          children: [
            Text(
              'Registra una cuenta en Joie Driver',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: jtextColor,
                  fontSize: getPropertieScreenWidth(28),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.03,
            ),
            const RegistroForm(),
            SizedBox(
              height: getPropertieScreenHeight(18),
            ),
            SizedBox(
              height: getPropertieScreenHeight(20),
            ),
            Text(
              'Al continuar con su confirmación es porque está de acuerdo con nuestros términos y condiciones',
              style: TextStyle(
                  color: jtextColorSec, fontSize: getPropertieScreenWidth(15)),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getPropertieScreenHeight(20),
            ),
          ],
        ),
    );
  }
}
