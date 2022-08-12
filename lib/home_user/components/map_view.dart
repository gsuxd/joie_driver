import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();

  LocationData? _currentLocation;

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((LocationData location) {
      setState(() {
        _currentLocation = location;
      });
    });
    GoogleMapController controller = await _controller.future;
    location.onLocationChanged.listen((LocationData location) {
      _currentLocation = location;
      getPolyPoints(true);
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 15,
        target: LatLng(
          location.latitude!,
          location.longitude!,
        ),
      )));
      setState(() {});
    });
  }

  static const LatLng sourceLocation = LatLng(37.4221, -122.0841);
  static const LatLng destinationLocation = LatLng(37.4116, -122.0713);

  List<LatLng> _polylineCoordinates = <LatLng>[];

  void getPolyPoints(bool isInitialized) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAEE30voT1-ycMD3-cxpq2m4oJcKrpLeRA",
      PointLatLng(
          isInitialized ? _currentLocation!.latitude! : sourceLocation.latitude,
          isInitialized
              ? _currentLocation!.longitude!
              : sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );
    if (result.points.isNotEmpty) {
      if (_polylineCoordinates.isNotEmpty) {
        _polylineCoordinates.clear();
      }
      setState(() {
        result.points.forEach((element) => _polylineCoordinates
            .add(LatLng(element.latitude, element.longitude)));
      });
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _currentLocation == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    _currentLocation!.latitude!, _currentLocation!.longitude!),
                zoom: 14.5),
            polylines: {
              Polyline(
                  polylineId: const PolylineId("polyline"),
                  points: _polylineCoordinates,
                  color: Colors.blue,
                  width: 3)
            },
            markers: {
              Marker(
                  markerId: const MarkerId('current'),
                  position: LatLng(_currentLocation!.latitude!,
                      _currentLocation!.longitude!)),
              const Marker(
                  markerId: MarkerId('destination'),
                  position: destinationLocation),
            },
            onMapCreated: (mapController) {
              _controller.complete(mapController);
            },
          );
  }
}
