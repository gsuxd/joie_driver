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
      appBar: AppBar(
        title: const Text('Por tu seguridad y la nuestra'),
        centerTitle: true,
        leading: Container(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 24,
              )),
        ),
      ),
      body: Body(widget.user),
    );
  }
}
