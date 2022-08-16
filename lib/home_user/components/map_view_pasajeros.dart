import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:location/location.dart';

class MapViewPasajeros extends StatefulWidget {
  const MapViewPasajeros({Key? key}) : super(key: key);

  @override
  State<MapViewPasajeros> createState() => _MapViewPasajerosState();
}

class _MapViewPasajerosState extends State<MapViewPasajeros> {
  late GoogleMapController _controller;

  List<Marker> _nearCars = <Marker>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PositionBloc, PositionState>(
      builder: (context, state) {
        if (state is PositionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PositionObtained) {
          return BlocListener<PositionBloc, PositionState>(
            listener: (context, state) {
              if (state is PositionObtained) {
                _controller.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                  zoom: 15,
                  target: LatLng(
                    state.location.latitude!,
                    state.location.longitude!,
                  ),
                )));
              }
            },
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target:
                    LatLng(state.location.latitude!, state.location.longitude!),
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('current_location'),
                  position: LatLng(
                      state.location.latitude!, state.location.longitude!),
                )
              },
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
            ),
          );
        }
        return const Center(
          child: Text(
              "Ocurrió un error obteniendo tu ubicación, porfavor verifica tu conexión a internet y habilita los "),
        );
      },
    );
  }
}
