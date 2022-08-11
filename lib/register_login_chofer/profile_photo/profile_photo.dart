import 'package:flutter/material.dart';
import '../../register_login_chofer/registro/user_data_register.dart';
import '../size_config.dart';
import '/register_login_chofer/profile_photo/components/body_cardP.dart';



class ProfilePhoto extends StatelessWidget {
  RegisterUser user;
  ProfilePhoto(this.user, {Key? key}) : super(key: key);

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