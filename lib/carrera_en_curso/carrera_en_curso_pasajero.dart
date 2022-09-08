import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';

import '../blocs/carrera/carrera_model.dart';

class CarreraEnCursoPagePasajero extends StatefulWidget {
  const CarreraEnCursoPagePasajero({Key? key, required this.choferId})
      : super(key: key);
  final String choferId;

  @override
  State<CarreraEnCursoPagePasajero> createState() =>
      _CarreraEnCursoPagePasajeroState();
}

class _CarreraEnCursoPagePasajeroState
    extends State<CarreraEnCursoPagePasajero> {
  // ignore: prefer_final_fields
  bool _isLoading = true;
  late Marker _chofer;
  void _load(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final chofer =
        FirebaseFirestore.instance.doc('users/${widget.choferId}').snapshots();
    await for (var e in chofer) {
      setState(() async {
        if (!_isLoading) {
          _isLoading = false;
        }
        _chofer = Marker(
          markerId: const MarkerId('chofer'),
          position: LatLng(e.get('latitude'), e.get('longitude')),
          icon: await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(10, 10)),
              "assets/images/coches-en-el-mapa.png"),
        );
      });
    }
  }

  @override
  void initState() {
    _load(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Carrera en curso'),
            Text('Chofer: ${widget.choferId}'),
            if (_isLoading && _chofer != null)
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      (context.watch<PositionBloc>().state as PositionObtained)
                          .location
                          .latitude!,
                      (context.watch<PositionBloc>().state as PositionObtained)
                          .location
                          .longitude!),
                  zoom: 15,
                ),
                markers: {_chofer},
              ),
          ],
        ),
      ),
    );
  }
}
