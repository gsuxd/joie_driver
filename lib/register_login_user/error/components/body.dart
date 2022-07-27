import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/default_button.dart';
import '../../conts.dart';
import '../../sign_in/log_in.dart';
import '../../size_config.dart';


class Body extends StatelessWidget {
  final Object? e;
  final StackTrace? stackTrace;
  const Body({Key? key, this.e, this.stackTrace}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.screenHeight * 0.03,
                right: SizeConfig.screenHeight * 0.01),
            child: SvgPicture.asset(error, height: MediaQuery.of(context).size.height*.45,),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          Text(
            'No exitoso',
            style: TextStyle(
              fontSize: getPropertieScreenWidth(20),
              fontWeight: FontWeight.w300,
              color: jtextColorSec,
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          Text(
            'Ocurrió un Error',
            style: TextStyle(
              fontSize: getPropertieScreenWidth(25),
              fontWeight: FontWeight.bold,
              color: jtextColorSec,
            ),
          ),
          const Spacer(),
          SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child: ButtonDef(
                  text: 'Intentelo otra vez',
                  press: () {
                    //lleva al login
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LognInScreenUser()));
                  })),
          const Spacer(),
        ],
      ),
    );
  }
}
