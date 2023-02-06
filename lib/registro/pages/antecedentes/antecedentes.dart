import 'package:flutter/material.dart';

import '../../../size_config.dart';
import './components/body_card.dart';

class Antecedentes extends StatelessWidget {
  const Antecedentes({Key? key}) : super(key: key);
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "antecedentes";
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
