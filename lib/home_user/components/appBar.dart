import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:get_it/get_it.dart';
import 'package:joiedriver/singletons/user_data.dart';
import 'package:location/location.dart';

class Appbar extends StatefulWidget implements PreferredSizeWidget {
  const Appbar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  @override
  void initState() {
    getCity();
    super.initState();
  }

  void getCity() async {
    Location location = Location();
    final locationData = await location.getLocation();
    List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData.latitude!, locationData.longitude!);
    var first = placemarks.first;
    print(
        ' ${first.locality}, ${first.subLocality}${first.thoroughfare}, ${first.subThoroughfare}');
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Row(
      children: [
        CircleAvatar(
          foregroundImage: NetworkImage(GetIt.I.get<UserData>().profilePicture),
        ),
        Row(children: [])
      ],
    ));
  }
}
