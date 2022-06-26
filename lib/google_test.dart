import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
class Mapa extends StatefulWidget {
  late double x;
  late double y;
  Mapa({ required double this.x, required double this.y});
  static const String routeName = '/Mapa';

  @override
  createState() =>  _MapaState(x: x, y: y);
}

class _MapaState extends State<Mapa> {
  late double x;
  late double y;
  _MapaState({ required double this.x, required double this.y});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        //bottomNavigationBar: Save(),

        body: MapSample(x: x, y:y));
  }


}

class MapSample extends StatefulWidget {
  late double x;
  late double y;
  MapSample({ required double this.x, required double this.y});
  @override
  State<MapSample> createState() => MapSampleState(x: x, y: y);
}

class MapSampleState extends State<MapSample> {

  MapSampleState({ required double this.x , required double this.y}){
  }

  late double x;
  late double y;
  late LatLng coor = LatLng(x, y);
  Completer<GoogleMapController> _controller = Completer();

  late CameraPosition _kGooglePlex = CameraPosition(
    target: coor,
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),

    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future<void> localizador() async {
    if (await Permission.location.request().isGranted) {
    // Permiso concedido
    }
  }
}