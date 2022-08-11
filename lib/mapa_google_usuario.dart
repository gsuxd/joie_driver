import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MapaUsuario extends StatefulWidget {
  late double x;
  late double y;

  MapaUsuario({required double this.x, required double this.y});

  static const String routeName = '/Mapa';

  @override
  createState() => _MapaState(x: x, y: y);
}

class _MapaState extends State<MapaUsuario> {
  late double x;
  late double y;

  _MapaState({required double this.x, required double this.y});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: MapSample(x: x, y: y));
  }
}

class MapSample extends StatefulWidget {
  late double x;
  late double y;

  MapSample({required double this.x, required double this.y});

  @override
  State<MapSample> createState() => MapSampleState(x: x, y: y);
}

class MapSampleState extends State<MapSample> {
  MapSampleState({required double this.x, required double this.y}) {}
  Set<Marker> markers = Set();

  late BitmapDescriptor myIcon;
  late BitmapDescriptor myIcon2;

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(96, 96)),
            'assets/images/iconito.png')
        .then((onValue) {
      myIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(96, 96)),
            'assets/images/coches-en-el-mapa.png')
        .then((onValue) {
      myIcon2 = onValue;
    });
  }

  late double x;
  late double y;
  late LatLng coor = LatLng(x, y);
  late LatLng coor2 = LatLng(x - 0.009, y - 0.001);
  late LatLng coor3 = LatLng(x - 0.003, y - 0.003);
  late LatLng coor4 = LatLng(x + 0.002, y + 0.002);
  final Completer<GoogleMapController> _controller = Completer();

  late final CameraPosition _kGooglePlex = CameraPosition(
    target: coor,
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: markers,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setState(() {
            markers = Set();
            markers.add(Marker(
              markerId: const MarkerId("target"),
              position: coor,
              icon: myIcon,
            ));
            markers.add(Marker(
              markerId: const MarkerId("target2"),
              position: coor2,
              icon: myIcon2,
            ));
            markers.add(Marker(
              markerId: const MarkerId("target3"),
              position: coor4,
              icon: myIcon2,
            ));
            markers.add(Marker(
              markerId: const MarkerId("target4"),
              position: coor3,
              icon: myIcon2,
            ));
          });
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
