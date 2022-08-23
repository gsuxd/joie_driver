import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();

  //List<LatLng> _polylineCoordinates = <LatLng>[];

  // void getPolyPoints(LocationData location) async {
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     "AIzaSyAEE30voT1-ycMD3-cxpq2m4oJcKrpLeRA",
  //     PointLatLng(location.latitude!, location.longitude!),
  //     PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
  //   );
  //   if (result.points.isNotEmpty) {
  //     if (_polylineCoordinates.isNotEmpty) {
  //       _polylineCoordinates.clear();
  //     }
  //     setState(() {
  //       result.points.forEach((element) => _polylineCoordinates
  //           .add(LatLng(element.latitude, element.longitude)));
  //     });
  //   }
  // }

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
          //polylines: {
          //  Polyline(
          //      polylineId: const PolylineId("polyline"),
          //      points: _polylineCoordinates,
          //      color: Colors.blue,
          //      width: 3)
          //},
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
