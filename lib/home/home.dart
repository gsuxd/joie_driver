import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/carrera/carrera_bloc.dart';
import 'package:joiedriver/home/components/map_view.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '/components/navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _loadData() async {
    final Location location = Location();
    final data = await location.getLocation();
    context.read<CarreraBloc>().add(
          ListenCarrerasEvent(
              LatLng(
                data.latitude!,
                data.longitude!,
              ),
              context),
        );
  }

  late StreamController _streamController;

  @override
  void initState() {
    _loadData();
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
