import 'package:flutter/material.dart';
import '../../register_login_emprendedor/registro/user_data_register.dart';
import '../size_config.dart';
import '/register_login_emprendedor/cedulaAlreves/components/body_cardP.dart';



class CedulaR extends StatelessWidget {
  RegisterUser user;
  CedulaR(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Por tu seguridad y la nuestra'),
        centerTitle: true,
      ),
      body:  Body(user),
    );
  }
}
