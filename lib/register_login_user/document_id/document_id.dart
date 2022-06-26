import 'package:joiedriver/register_login_user/registro/user_data_register.dart';
import 'package:flutter/material.dart';
import '../size_config.dart';
import 'components/body_propiety.dart';


class DocumentId extends StatelessWidget {
  static String routeName = '/propiety';
  RegisterUser user;
  DocumentId(this.user);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(user),
    );
  }
}
