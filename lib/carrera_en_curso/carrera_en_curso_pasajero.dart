import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/carrera/carrera_model.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';

class CarreraEnCursoPagePasajero extends StatefulWidget {
  const CarreraEnCursoPagePasajero(
      {Key? key, required this.carreraRef, required this.carrera})
      : super(key: key);
  final DocumentReference<Map<String, dynamic>> carreraRef;
  final Carrera carrera;

  @override
  State<CarreraEnCursoPagePasajero> createState() =>
      _CarreraEnCursoPagePasajeroState();
}

class _CarreraEnCursoPagePasajeroState
    extends State<CarreraEnCursoPagePasajero> {
  // ignore: prefer_final_fields
  Marker? _chofer;
  BitmapDescriptor? _markerAIcon;
  BitmapDescriptor? _markerBIcon;
  void _load(BuildContext context) async {
    _markerAIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(12, 12)),
        "assets/images/pint-A-indicator.png");
    _markerBIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(12, 12)),
        "assets/images/pint-B-indicator.png");
    final _ = Carrera.fromJson((await widget.carreraRef.get()).data()!);
    final chofer =
        FirebaseFirestore.instance.doc('users/${_.choferId}').snapshots();
    chofer.listen(_handleSnapshot);
  }

  GoogleMapController? _controller;

  void _handleSnapshot(e) async {
    // ignore: unnecessary_null_comparison
    if (_controller != null) {
      final location = e.get('location');
      _chofer = Marker(
        markerId: const MarkerId('chofer'),
        position: LatLng(location['latitude'], location['longitude']),
        icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(10, 10)),
            "assets/images/coches-en-el-mapa.png"),
      );
      setState(() {});
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            tilt: 90,
            zoom: 18,
            target: LatLng(
              location['latitude'],
              location['longitude'],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
              _load(context);
            },
            initialCameraPosition: CameraPosition(
              tilt: 90,
              target: LatLng(
                  (context.watch<PositionBloc>().state as PositionObtained)
                      .location
                      .latitude!,
                  (context.watch<PositionBloc>().state as PositionObtained)
                      .location
                      .longitude!),
              zoom: 18,
            ),
            markers: {
              if (_markerAIcon != null) ...{
                Marker(
                    markerId: const MarkerId("A Point"),
                    icon: _markerAIcon!,
                    position: widget.carrera.inicio),
                Marker(
                    markerId: const MarkerId("B Point"),
                    icon: _markerBIcon!,
                    position: (widget.carrera.destino)),
              },
              if (_chofer != null) _chofer!
            },
          ),
        ],
      ),
    );
  }
}
