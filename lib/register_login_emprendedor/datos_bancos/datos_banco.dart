import 'package:flutter/material.dart';
import '../../register_login_emprendedor/registro/user_data_register.dart';
import 'components/body_banco.dart';

class DatosBanco extends StatelessWidget {
  final RegisterUser user;
  const DatosBanco(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left)),
        title: const Text('Completar Perfil'),
      ),
      body: Body(user),
    );
  }
}
