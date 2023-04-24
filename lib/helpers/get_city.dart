import 'package:geocoding/geocoding.dart';

Future<String> getCity(locationData) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(
      locationData.latitude!, locationData.longitude!);
  var first = placemarks.first;
  return first.locality!;
}
