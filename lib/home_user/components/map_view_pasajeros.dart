import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapViewPasajeros extends StatefulWidget {
  const MapViewPasajeros({Key? key}) : super(key: key);

  @override
  State<MapViewPasajeros> createState() => _MapViewPasajerosState();
}

class _MapViewPasajerosState extends State<MapViewPasajeros> {
  LocationData? _currentLocation;
  final Completer<GoogleMapController> _controller = Completer();

  List<Marker> _nearCars = <Marker>[];

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((LocationData location) {
      _currentLocation = location;
      setState(() {});
    });
    GoogleMapController controller = await _controller.future;
    location.onLocationChanged.listen((LocationData location) async {
      _currentLocation = location;
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

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentLocation == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target:
            LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        zoom: 15,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('current_location'),
          position:
              LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        )
      },
      myLocationButtonEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
