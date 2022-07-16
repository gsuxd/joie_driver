import 'package:flutter/material.dart';
import '../conts.dart';
import '../share/components/body.dart';
import '../size_config.dart';

class ComparteYGana extends StatefulWidget {
  String codeLogin;
  ComparteYGana(this.codeLogin, {Key? key}) : super(key: key);


  @override
  _ComparteYGanaState createState() => _ComparteYGanaState(codeLogin);
}

class _ComparteYGanaState extends State<ComparteYGana> {
  String codeLogin;
  _ComparteYGanaState(this.codeLogin);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        //Este sccafoldKey en el const.dart
        key: scaffoldKey,
        body:  Body(codeLogin),
      ),
    );
  }
}
