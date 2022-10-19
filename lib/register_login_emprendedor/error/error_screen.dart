import 'package:flutter/material.dart';
import '../size_config.dart';
import 'components/body.dart';
export 'components/body.dart';

class OpError extends StatelessWidget {
  static String routeName = '/error';
  final Object? e;
  final StackTrace? stackTrace;
  const OpError({Key? key, this.e, required this.stackTrace}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Error de Operación',
        ),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}
