import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PositionBloc, PositionState>(builder: (context, state) {
      if (state is PositionLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is PositionObtained) {
        return GoogleMap(
          initialCameraPosition: CameraPosition(
              target:
                  LatLng(state.location.latitude!, state.location.longitude!),
              zoom: 14.5),
          markers: {
            Marker(
                markerId: const MarkerId('current'),
                position: LatLng(
                    state.location.latitude!, state.location.longitude!)),
          },
          onMapCreated: (mapController) {
            _controller.complete(mapController);
          },
        );
      }
      return const Center(
        child: Text('Error'),
      );
    });
  }
}
