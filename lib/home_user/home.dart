import 'package:flutter/material.dart';
import 'package:joiedriver/home/components/map_view.dart';
import 'package:joiedriver/home_user/components/appBar.dart';
import '/components/navigation_drawer.dart';
import 'components/map_view_pasajeros.dart';

class HomeScreenUser extends StatelessWidget {
  static String routeName = '/home';

  const HomeScreenUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Appbar(),
      drawer: NavigationDrawer(),
      body: MapViewPasajeros(),
    );
  }
}
