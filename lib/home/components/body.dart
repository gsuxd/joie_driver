import 'package:flutter/material.dart';
import '../../register_login_chofer/share/comparte.dart';


class Body extends StatelessWidget {
  String codeLogin;
   Body(this.codeLogin, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComparteYGana(codeLogin);
  }
}
