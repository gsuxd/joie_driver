import 'package:joiedriver/register_login_user/registro/user_data_register.dart';
import 'package:flutter/material.dart';
import '../size_config.dart';
import 'components/body_propiety.dart';

class DocumentId extends StatelessWidget {
  final RegisterUser user;
  const DocumentId(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(user: user),
    );
  }
}
