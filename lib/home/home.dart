import 'package:joiedriver/register_login_chofer/share/comparte.dart';
import 'package:flutter/material.dart';
import '/components/navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  String codeLogin;
   HomeScreen(this.codeLogin, {Key? key}) : super(key: key);



  @override
  State<HomeScreen> createState() => _HomeScreenState(codeLogin);
}

class _HomeScreenState extends State<HomeScreen> {
  String codeLogin;
  _HomeScreenState(this.codeLogin);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('En Desarrollo'),
      ),
      drawer: const NavigationDrawer(),
      body:  ComparteYGana(codeLogin),
    );
  }
}
