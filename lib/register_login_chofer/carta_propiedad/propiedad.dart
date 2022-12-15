import 'package:joiedriver/register_login_chofer/registro/conductor_data_register.dart';
import 'package:flutter/material.dart';
import '../size_config.dart';
import 'components/body_propiety.dart';


class PropiedadScreen extends StatelessWidget {
  static String routeName = '/propiety';
  RegisterConductor user;
  PropiedadScreen(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(

      body: Body(user:user),
    );
  }
}
