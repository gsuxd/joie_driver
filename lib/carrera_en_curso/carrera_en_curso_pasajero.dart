import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/carrera/carrera_model.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';

class CarreraEnCursoPagePasajero extends StatefulWidget {
  const CarreraEnCursoPagePasajero({Key? key, required this.carreraRef})
      : super(key: key);
  final DocumentReference<Map<String, dynamic>> carreraRef;

  @override
  State<CarreraEnCursoPagePasajero> createState() =>
      _CarreraEnCursoPagePasajeroState();
}

class _CarreraEnCursoPagePasajeroState
    extends State<CarreraEnCursoPagePasajero> {
  // ignore: prefer_final_fields
  bool _isLoading = true;
  Marker? _chofer;
  void _load(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final _ = Carrera.fromJson((await widget.carreraRef.get()).data()!);
    final chofer =
        FirebaseFirestore.instance.doc('users/${_.choferId}').snapshots();
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
                markers: {
                  _chofer!,
                },
              ),
          ],
        ),
      ),
    );
  }
}
