import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:joiedriver/home/components/map_view.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import '/components/navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<PositionBloc>().add(GetPositionEvent(context));
    super.initState();
  }

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
