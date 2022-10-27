import 'package:flutter/material.dart';
import '../registro/conductor_data_register.dart';
import '../size_config.dart';
import 'components/body_antecedents.dart';

class AntecedentsScreen extends StatefulWidget {
  RegisterConductor user;
  AntecedentsScreen(this.user, {Key? key}) : super(key: key);
  @override
  createState() =>  _AntecedentsScreen(user);

}

class _AntecedentsScreen extends State<AntecedentsScreen> {
  RegisterConductor user;
  _AntecedentsScreen(this.user);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Por tu seguridad y la nuestra'),
        centerTitle: true,
        leading:
        Container(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24,)
          ),
        ),
      ),
      body: Body(user),
    );
  }
}