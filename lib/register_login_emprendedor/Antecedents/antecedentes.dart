import 'package:flutter/material.dart';
import 'package:joiedriver/register_login_chofer/conts.dart';
import '../registro/user_data_register.dart';
import '../size_config.dart';
import 'components/body_antecedents.dart';

class AntecedentsScreen extends StatefulWidget {
  RegisterUser user;
  AntecedentsScreen(this.user, {Key? key}) : super(key: key);
  @override
  createState() =>  _AntecedentsScreen(user);

}

class _AntecedentsScreen extends State<AntecedentsScreen> {
  RegisterUser user;
  _AntecedentsScreen(this.user);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(user:user),
    );
  }
}