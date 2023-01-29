import 'package:flutter/material.dart';
import '../../register_login_user/registro/user_data_register.dart';
import '../size_config.dart';
import 'components/body_cardP.dart';

class ProfilePhoto extends StatelessWidget {
  final RegisterUser user;
  const ProfilePhoto(this.user, {Key? key}) : super(key: key);
  static String routeName = '/card_propierty';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Por tu seguridad y la nuestra'),
        centerTitle: true,
      ),
      body: Body(user),
    );
  }
}
