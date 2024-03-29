import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/carrera/carrera_model.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:joiedriver/helpers/calculate_distance.dart';

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
  late BitmapDescriptor _markerAIcon;
  late BitmapDescriptor _markerBIcon;
  void _loadIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(12, 12)),
        "assets/images/coches-en-el-mapa.png");
    _markerAIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(12, 12)),
        "assets/images/pint-A-indicator.png");
    _markerBIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(12, 12)),
        "assets/images/pint-B-indicator.png");
    setState(() {});
  }

  void _handlePositionState(PositionState state) async {
    if (state is PositionObtained) {
      final distance = calculateDistance(
          LatLng(state.location.latitude!, state.location.longitude!),
          widget.carrera.inicio);
      if (distance < 0.5) {
        PolylinePoints polylinePoints = PolylinePoints();
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          "AIzaSyAEE30voT1-ycMD3-cxpq2m4oJcKrpLeRA",
          PointLatLng(state.location.latitude!, state.location.longitude!),
          PointLatLng(widget.carrera.destino.latitude,
              widget.carrera.destino.longitude),
        );
        setState(() {
          _polylinePoints = result;
        });
      } else {
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
                  Marker(
                      markerId: const MarkerId("A Point"),
                      icon: _markerAIcon,
                      position: (context.read<CarreraEnCursoBloc>().state
                              as CarreraEnCursoChofer)
                          .carrera
                          .inicio),
                  Marker(
                      markerId: const MarkerId("B Point"),
                      icon: _markerBIcon,
                      position: (context.read<CarreraEnCursoBloc>().state
                              as CarreraEnCursoChofer)
                          .carrera
                          .destino)
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
