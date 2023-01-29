import 'package:joiedriver/register_login_chofer/registro/user_data_register.dart';
import 'package:flutter/material.dart';
import '../size_config.dart';
import 'components/body_cardP.dart';

class CardPropierty extends StatelessWidget {
  final RegisterUser user;
  const CardPropierty(this.user, {Key? key}) : super(key: key);
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
