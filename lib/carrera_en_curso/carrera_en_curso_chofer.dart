import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/carrera/carrera_model.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';

import 'bloc/carrera_en_curso_bloc.dart';

class CarreraEnCursoPage extends StatefulWidget {
  const CarreraEnCursoPage(
      {Key? key, required this.carreraRef, required this.carrera})
      : super(key: key);

  final DocumentReference<Map<String, dynamic>> carreraRef;
  final Carrera carrera;

  @override
  State<CarreraEnCursoPage> createState() => _CarreraEnCursoPageState();
}

class _CarreraEnCursoPageState extends State<CarreraEnCursoPage> {
  late BitmapDescriptor _markerIcon;
  void _loadIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(12, 12)),
        "assets/images/coches-en-el-mapa.png");
    setState(() {});
  }

  void _handlePositionState(PositionState state) async {
    if (state is PositionObtained) {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyAEE30voT1-ycMD3-cxpq2m4oJcKrpLeRA",
        PointLatLng(state.location.latitude!, state.location.longitude!),
        PointLatLng(
            widget.carrera.inicio.latitude, widget.carrera.inicio.longitude),
      );
      setState(() {
        _polylinePoints = result;
      });
    }
  }

  PolylineResult _polylinePoints = PolylineResult();

  @override
  void initState() {
    _loadIcon();
    context
        .read<CarreraEnCursoBloc>()
        .add(CargarCarreraEnCursoEvent(widget.carreraRef, context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<CarreraEnCursoBloc, CarreraEnCursoState>(
          builder: (context, state) {
            if (state is CarreraEnCursoCancelada) {
              return const Text('Carrera cancelada');
            }

            if (state is CarreraEnCursoLoading) {
              return const CircularProgressIndicator();
            }

            return BlocConsumer<PositionBloc, PositionState>(
              listener: (context, state) => _handlePositionState(state),
              builder: (context, state) => GoogleMap(
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("polyline"),
                    points: _polylinePoints.points
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList(),
                    color: Colors.blue,
                    width: 5,
                  )
                },
                markers: {
                  if (state is PositionObtained)
                    Marker(
                      markerId: const MarkerId('position'),
                      icon: _markerIcon,
                      position: LatLng(
                        state.location.latitude!,
                        state.location.longitude!,
                      ),
                    ),
                  Marker(
                      markerId: const MarkerId("A Point"),
                      position: (context.read<CarreraEnCursoBloc>().state
                              as CarreraEnCursoChofer)
                          .carrera
                          .inicio)
                },
                initialCameraPosition: CameraPosition(
                  zoom: 13.5,
                  target: LatLng((state as PositionObtained).location.latitude!,
                      (state).location.longitude!),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
