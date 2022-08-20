import 'package:flutter/material.dart';
import '../sign_in/components/body.dart';
import '../size_config.dart';

class LognInScreenEmprendedor extends StatelessWidget {
  static String routename = "/login";
  const LognInScreenEmprendedor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ) {
    
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left, size: 30,)),
        title: const Text(
          "Iniciar Sesión",
        ),
        centerTitle: true,
      ),
      body: const BodySign(),
    );
  }
}
