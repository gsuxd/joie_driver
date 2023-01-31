import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/carrera/carrera_model.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:joiedriver/carrera_en_curso/bloc/carrera_en_curso_bloc.dart';
import 'package:joiedriver/helpers/calculate_distance.dart';
import 'package:joiedriver/helpers/get_polyline_points.dart';

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
  PolylineResult? _polylineResult;
  double? _timer;
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
    _choferSub = chofer.listen(_handleSnapshot);
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_timer == 1.0) {
        timer.cancel();
        return;
      }
      _timer ??= 0;
      _timer = _timer! + 0.05;
      setState(() {});
    });
  }

  GoogleMapController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    _choferSub?.cancel();
    super.dispose();
  }

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _choferSub;

  void _handleSnapshot(e) async {
    // ignore: unnecessary_null_comparison
    if (_controller != null) {
      final location = e.get('location');
      final LatLng choferLocation =
          LatLng(location['latitude'], location['longitude']);
      _chofer = Marker(
        markerId: const MarkerId('chofer'),
        position: choferLocation,
        icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(10, 10)),
            "assets/images/coches-en-el-mapa.png"),
      );
      final distanceA =
          calculateDistance(widget.carrera.inicio, choferLocation);
      final distanceB =
          calculateDistance(widget.carrera.destino, choferLocation);
      if (distanceA <= 0.010 && distanceB > 0.010) {
        _markerAIcon = null;

        _polylineResult =
            await getPolypoints(choferLocation, widget.carrera.destino);
      } else {
        _polylineResult =
            await getPolypoints(choferLocation, widget.carrera.inicio);
      }
      if (distanceB <= 0.010 && distanceA > 0.010) {
        _markerBIcon = null;
        await widget.carreraRef.update({
          'finalizada': true,
        });
        _polylineResult =
            await getPolypoints(choferLocation, widget.carrera.inicio);
      }
      setState(() {});
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            tilt: 70,
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
            polylines: {
              if (_polylineResult != null)
                Polyline(
                    polylineId: const PolylineId("Route"),
                    color: Colors.blue,
                    points: _polylineResult!.points
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList())
            },
            initialCameraPosition: CameraPosition(
              tilt: 70,
              target: LatLng(
                  (context.watch<PositionBloc>().state as PositionObtained)
                      .location
                      .latitude,
                  (context.watch<PositionBloc>().state as PositionObtained)
                      .location
                      .longitude),
              zoom: 18,
            ),
            markers: {
              if (_markerAIcon != null)
                Marker(
                    markerId: const MarkerId("A Point"),
                    icon: _markerAIcon!,
                    position: widget.carrera.inicio),
              if (_markerBIcon != null)
                Marker(
                    markerId: const MarkerId("B Point"),
                    icon: _markerBIcon!,
                    position: (widget.carrera.destino)),
              if (_chofer != null) _chofer!
            },
          ),
          if (_timer != null && _timer! == 1)
            Positioned(
                bottom: 50,
                left: 120,
                child: SizedBox(
                  width: 150.0,
                  height: 150.0,
                  child: Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 150.0,
                          height: 150.0,
                          child: CircularProgressIndicator(
                            value: _timer!,
                            strokeWidth: 12,
                            valueColor:
                                const AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: IconButton(
                            splashColor: Colors.blue,
                            color: Colors.red,
                            onPressed: () {
                              context.read<CarreraEnCursoBloc>().add(
                                  CancelarCarreraEnCursoEvent(
                                      carreraRef: widget.carreraRef,
                                      carrera: widget.carrera,
                                      context: context));
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 100,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
        ],
      ),
    );
  }
}
