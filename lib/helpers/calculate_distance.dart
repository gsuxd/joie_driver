import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

double calculateDistance(LatLng pos1, LatLng pos2) {
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((pos2.latitude - pos1.latitude) * p) / 2 +
      cos(pos1.latitude * p) *
          cos(pos2.latitude * p) *
          (1 - cos((pos2.longitude - pos1.longitude) * p)) /
          2;
  return 12742 * asin(sqrt(a));
}
