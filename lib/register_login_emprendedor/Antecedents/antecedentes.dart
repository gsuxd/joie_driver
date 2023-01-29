import 'package:flutter/material.dart';
import '../registro/user_data_register.dart';
import '../size_config.dart';
import 'components/body_antecedents.dart';

class AntecedentsScreen extends StatefulWidget {
  final RegisterUser user;
  const AntecedentsScreen(this.user, {Key? key}) : super(key: key);
  @override
  createState() => _AntecedentsScreen();
}

class _AntecedentsScreen extends State<AntecedentsScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(user: widget.user),
    );
  }
}
