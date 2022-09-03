import 'package:joiedriver/register_login_user/share/comparte.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../mapa_principal.dart';
import '/components/navigation_drawer.dart';
import 'package:permission_handler/permission_handler.dart';


class HomeScreenUser extends StatefulWidget {
  static String routeName = '/home';

  HomeScreenUser({Key? key}) : super(key: key);

  @override
  State<HomeScreenUser> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenUser> {

  @override
  Widget build(BuildContext context) {
    // void initState() {
    //   super.initState();
    //   goPrincipalMenu(context);
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('En Desarrollo'),
      ),
      //drawer: const NavigationDrawer(),
      body: ComparteYGana(),
    );
  }
}
