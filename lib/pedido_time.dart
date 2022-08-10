import 'package:joiedriver/pedidos.dart';
import 'package:joiedriver/profile.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'colors.dart';
import 'estatics.dart';
import 'mapa_principal.dart';

class PedidosTime extends StatefulWidget {
  @override
  createState() => _PedidosTimeState();
}

class _PedidosTimeState extends State<PedidosTime> {
  String url_img = "https://picsum.photos/seed/913/400";
  Color color_icon_inicio = blue;
  Color color_icon_historial = blue_dark;
  Color color_icon_perfil = blue;
  Color color_icon_ingresos = blue;
  String state = "Desconectado";
  bool isSwitched = false;
  String puntoA = "Centro Comercial el Loco";
  String puntoB = "El Trebol, Avenida Buena Suerte";
  double monto = 56.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: blue,
          leading: GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              "assets/images/perfil_principal.svg",
              width: 24,
              color: Colors.white,
            ),
          ),
          title: const Center(
            child: Text(
              "Pedidos",
              style: TextStyle(
                  fontFamily: "Monserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ),
          actions: [conectSwitch(context)],
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(10.0),
              children: [
                Container(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        url_img,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          puntoA,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontFamily: "monserrat"),
                        ),
                        Text(
                          puntoB,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                              fontFamily: "monserrat"),
                        ),
                        Text(
                          "$monto \$",
                          style: const TextStyle(
                              color: blue,
                              fontSize: 12,
                              fontFamily: "monserrat"),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  height: 20.0,
                ),
                const Center(
                  child: Text(
                    "Cuanto tiempo le tomara\nllegar al pasajero?",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontFamily: "monserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 20.0,
                ),
                time("3 min.", Colors.white),
                time("5 min.", Colors.white),
                time("10 min.", Colors.white),
                time("15 min.", Colors.white),
                time("mas", Colors.black87),
                Container(
                  height: 60.0,
                ),
              ],
            ),
            Positioned(bottom: 10, left: 0.0, child: bottomNavBar(context))
          ],
        ));
  }

  ElevatedButton time(String time, Color color) {
    return ElevatedButton(
      onPressed: () {
        setState(() {});
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
        shadowColor: Colors.grey,
        primary: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
      child: Text(
        time,
        style: TextStyle(
            color: color,
            fontFamily: "Monserrat",
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
    );
  }

  Widget conectSwitch(BuildContext context) {
    return Switch(
      value: isSwitched,
      onChanged: (value) {
        setState(() {
          isSwitched = value;
          if (state == "Desconectado") {
            state = "Conectado";
          } else {
            state = "Desconectado";
          }
        });
      },
      activeTrackColor: Colors.green,
      activeColor: Colors.white,
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: Colors.grey,
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
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Statics()));
            },
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
}
