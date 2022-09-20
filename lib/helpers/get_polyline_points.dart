import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<PolylineResult> getPolypoints(LatLng pos1, LatLng pos2) async {
  final PolylinePoints polylinePoints = PolylinePoints();
  return await polylinePoints.getRouteBetweenCoordinates(
    "AIzaSyAEE30voT1-ycMD3-cxpq2m4oJcKrpLeRA",
    PointLatLng(pos1.latitude, pos2.longitude),
    PointLatLng(pos2.latitude, pos2.longitude),
  );
}
