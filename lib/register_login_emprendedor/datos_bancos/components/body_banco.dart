import 'package:flutter/material.dart';
import '../../../register_login_emprendedor/conts.dart';
import '../../../register_login_emprendedor/size_config.dart';
import '../../../register_login_emprendedor/registro/user_data_register.dart';
import 'form_datos.dart';

class Body extends StatefulWidget {
  final RegisterUser user;
  const Body(this.user, {Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: BancoForm(widget.user),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
