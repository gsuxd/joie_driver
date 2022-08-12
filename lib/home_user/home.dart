import 'package:flutter/material.dart';
import 'package:joiedriver/home_user/components/map_view.dart';
import '/components/navigation_drawer.dart';

class HomeScreenUser extends StatelessWidget {
  static String routeName = '/home';

  const HomeScreenUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('En Desarrollo'),
      ),
      drawer: const NavigationDrawer(),
      body: const MapView(),
    );
  }
}
