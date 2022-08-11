import 'package:joiedriver/pedidos.dart';
import 'package:joiedriver/profile.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'GraphiStats.dart';
import 'colors.dart';
import 'mapa_principal.dart';

class Statics extends StatefulWidget {
  static const String routeName = '/Register';

  const Statics({Key? key}) : super(key: key);

  @override
  createState() => _StaticsState();
}

class _StaticsState extends State<Statics> {
  Color color_icon_inicio = blue;
  Color color_icon_historial = blue;
  Color color_icon_perfil = blue;
  Color color_icon_ingresos = blue_dark;
  final ScrollController _controller = ScrollController();
  final double _bottomNavBarHeight = 80;
  late final ScrollListener _model =
      ScrollListener.initialise(_controller, _bottomNavBarHeight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        leading: GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            "assets/images/perfil_principal.svg",
            width: 24.0,
            color: Colors.white,
          ),
        ),
        title: const Center(
          child: Text(
            "Ganancias",
            style: TextStyle(
                fontFamily: "Monserrat",
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            textAlign: TextAlign.left,
          ),
        ),
        actions: const [
          SizedBox(
            width: 24.0,
            height: 24.0,
          )
        ],
      ),
      body: animacion(context),
    );
  }

  ListView list() {
    return ListView(
      controller: _controller,
      children: [
        Container(
          height: 10.0,
        ),
        const Text(
          'Su ganancia el dia de hoy es de: 180.000 \$',
          style: TextStyle(
              fontFamily: "Monserrat",
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: blue),
          textAlign: TextAlign.center,
        ),
        // Graficos
        GraphicPie(),
        //Fin de Graficos

        item("Viajes de Hoy", 5),
        item("Viajes Completados", 96),
        item("Viajes Cancelados", 23),
        item("Viajes Rechazados", 54),
        item("Viajes Aceptados", 124),
        item("Viajes Cancelados por Cliente", 41),
        Container(
          height: 20.0,
        ),
        const Text(
          'Su ganancia en JoieDriver es de:',
          style: TextStyle(
              fontFamily: "Monserrat",
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: blue),
          textAlign: TextAlign.center,
        ),
        Container(
          height: 10.0,
        ),
        const Text(
          '5.00.124 \$',
          style: TextStyle(
              fontFamily: "Monserrat",
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: blue),
          textAlign: TextAlign.center,
        ),
        Container(
          height: 20.0,
        ),
      ],
    );
  }

  AnimatedBuilder animacion(BuildContext context) {
    return AnimatedBuilder(
      animation: _model,
      builder: (context, child) {
        return Stack(
          children: [
            list(),
            Positioned(
              left: 0,
              right: 0,
              bottom: _model.bottom,
              child: bottomNavBar(context),
            ),
          ],
        );
      },
    );
  }

  SizedBox bottomNavBar(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
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
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              primary: color_icon_inicio,
              shape: const CircleBorder(),
            ),
            child: SvgPicture.asset(
              "assets/images/inicio.svg",
              width: 40,
              color: Colors.white,
            ),
          ),
          Container(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Pedidos()));
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              primary: color_icon_historial,
              shape: const CircleBorder(),
            ),
            child: SvgPicture.asset(
              "assets/images/historial.svg",
              width: 40,
              color: Colors.white,
            ),
          ),
          Container(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              primary: color_icon_ingresos,
              shape: const CircleBorder(),
            ),
            child: SvgPicture.asset(
              "assets/images/ingresos.svg",
              width: 40,
              color: Colors.white,
            ),
          ),
          Container(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              });
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              primary: color_icon_perfil,
              shape: const CircleBorder(),
            ),
            child: SvgPicture.asset(
              "assets/images/perfil.svg",
              width: 40,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
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

  Padding item(String title, int count) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontFamily: "Monserrat",
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
          ),
          Text(
            '$count',
            style: const TextStyle(
                fontFamily: "Monserrat",
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

class ScrollListener extends ChangeNotifier {
  double bottom = 0, top = 0;
  double _last = 0, _first = 0;

  ScrollListener.initialise(ScrollController controller, [double height = 56]) {
    controller.addListener(() {
      final current = controller.offset;

      bottom += _last - current;
      if (bottom <= -height) bottom = -height;
      if (bottom >= 0) bottom = 0;
      _last = current;
      if (bottom <= 0 && bottom >= -height) notifyListeners();

      top += _first - current;
      if (top <= -height) top = -height;
      if (top >= 0) top = 0;
      _first = current;
      if (top <= 0 && top >= -height) notifyListeners();
    });
  }
}
