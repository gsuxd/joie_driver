import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:joiedriver/home/components/map_view.dart';
import 'package:joiedriver/home_user/components/appBar.dart';
import 'package:joiedriver/singletons/user_data.dart';
import '/components/navigation_drawer.dart';
import 'components/map_view_pasajeros.dart';

class HomeScreenUser extends StatefulWidget {
  static String routeName = '/home';

  const HomeScreenUser({Key? key}) : super(key: key);

  @override
  State<HomeScreenUser> createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {
  @override
  void initState() {
    context.read<PositionBloc>().add(
        GetPositionEvent((context.read<UserBloc>().state as UserLogged).user));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Appbar(),
      drawer: NavigationDrawer(),
      body: MapViewPasajeros(),
    );
  }
}
