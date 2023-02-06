import 'package:flutter/material.dart';
import '../conts.dart';
import '../share/components/body.dart';
import '../size_config.dart';

class ComparteYGana extends StatefulWidget {
  static String routeName = '/comparte';
  const ComparteYGana({Key? key}) : super(key: key);

  @override
  _ComparteYGanaState createState() => _ComparteYGanaState();
}

class _ComparteYGanaState extends State<ComparteYGana> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        //Este sccafoldKey en el const.dart
//late GlobalKey<ScaffoldState>? scaffoldKey;

        key: scaffoldKey,
        body: const Body(),
      ),
    );
  }
}
