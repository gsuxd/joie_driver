import 'package:flutter/material.dart';
import 'package:joiedriver/size_config.dart';
import './components/body_card.dart';

class CedulaR extends StatelessWidget {
  const CedulaR({Key? key}) : super(key: key);
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "cedulaR";
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Por tu seguridad y la nuestra'),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}
