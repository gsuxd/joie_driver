import 'package:flutter/material.dart';
import 'package:joiedriver/conts.dart';
import 'package:joiedriver/size_config.dart';
import 'form_datos.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ListView(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Text(
            'Ingrese los datos de una \n cuenta de su propiedad',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: jtextColor,
                fontSize: getPropertieScreenWidth(28),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.03,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: BancoForm(),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
