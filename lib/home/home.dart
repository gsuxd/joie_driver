import 'package:joiedriver/register_login_chofer/share/comparte.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../mapa_principal.dart';
import '/components/navigation_drawer.dart';
import 'package:permission_handler/permission_handler.dart';

// class HomeScreen extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return
//     Scaffold(
//       appBar: AppBar(
//         title: Text('En Desarrollo'),
//       ),
//       drawer: NavigationDrawer(),
//       body: Body(),
//     );
//   }
// }
class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    // void initState() {
    //   super.initState();
    //   goPrincipalMenu(context);
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('En Desarrollo'),
      ),
      drawer: const NavigationDrawer(),
      body: ComparteYGana(),
    );
  }

  goPrincipalMenu(BuildContext context) async {
    Future<Position> coord = _determinePosition();
    double longitude = await coord.then((value) => value.longitude);
    double latitude = await coord.then((value) => value.latitude);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MapaMenu(
                  longitude: longitude,
                  latitude: latitude,
                )));
  }

  Future<void> permiso() async {
    if (await Permission.location.request().isGranted) {
      // Permiso concedido
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }
}
