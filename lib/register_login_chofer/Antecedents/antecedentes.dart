import 'package:flutter/material.dart';
import '../registro/user_data_register.dart';
import '../size_config.dart';
import 'components/body_antecedents.dart';

class AntecedentsScreen extends StatefulWidget {
  RegisterUser user;
  AntecedentsScreen(this.user);
  @override
  createState() =>  _AntecedentsScreen(user);

}

class _AntecedentsScreen extends State<AntecedentsScreen> {
  RegisterUser user;
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
          padding: EdgeInsets.all(5.0),
          child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24,)
          ),
        ),
      ),
      body: Body(user),
    );
  }
}
//para probar
