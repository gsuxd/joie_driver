import 'package:joiedriver/pedidos.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'colors.dart';
import 'estatics.dart';
import 'mapa_principal.dart';

class Profile extends StatefulWidget {
  static const String routeName = '/Register';

  @override
  createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String usuario = "-----usuarioPruebaCho------";
  String state = "Desconectado";
  String calificacionPonderada = "0.0";
  bool isSwitched = false;
  Color color_icon_inicio = blue;
  Color color_icon_historial = blue;
  Color color_icon_perfil = blue_dark;
  Color color_icon_ingresos = blue;

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
              "Tu Perfil",
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
              children: [
                Container(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hola",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Monserrat",
                              fontWeight: FontWeight.bold,
                              color: blue),
                        ),
                        const Text(
                          "Andrea",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Monserrat",
                              fontWeight: FontWeight.bold,
                              color: blue),
                        ),
                        Image.asset(
                          "assets/images/estrella5.png",
                          height: 15,
                        ),
                      ],
                    ),
                    Container(
                      width: 10,
                    ),
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/girld2.jpg"),
                    ),
                    Container(
                      width: 10,
                    ),
                  ],
                ),
                Container(
                  height: 5.0,
                ),
                Container(
                  color: blue,
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 5.0, right: 5.0, left: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      itemMenu("Editar perfil", "assets/images/profile.svg"),
                      itemMenu("Asistencia\Tecnica",
                          "assets/images/asistencia_tecnica.svg"),
                      itemMenu(
                          "Notificaciones", "assets/images/notificaciones.svg"),
                      itemMenu("Recargar\nSaldo", "assets/images/recargar.svg"),
                    ],
                  ),
                ),
                Container(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Container(
                      width: 10.0,
                    ),
                    const Text(
                      "Mi Cuenta",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20.0,
                          fontFamily: "Monserrat",
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Container(
                  height: 10.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 20.0,
                    ),
                    Text(
                      "Saldo",
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontFamily: "Monserrat",
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 100.0,
                    ),
                    Text(
                      "56.000 \$",
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Monserrat",
                          fontWeight: FontWeight.bold,
                          color: blue),
                    ),
                    Container(
                      width: 10.0,
                    ),
                  ],
                ),
                Container(
                  height: 5.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 20.0,
                    ),
                    const Text(
                      "Calificacion",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontFamily: "Monserrat",
                          fontWeight: FontWeight.bold),
                    ),
                    FutureBuilder(
                      future: stars(),
                      builder: (BuildContext context,
                          AsyncSnapshot<Widget> snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data!;
                        }
                        return Container();
                      },
                    ),
                    Container(
                      width: 10.0,
                    ),
                    Container(
                      width: 10.0,
                    ),
                  ],
                ),
                const Divider(
                  height: 20,
                  color: Colors.black54,
                  thickness: 4,
                ),
                Row(
                  children: [
                    Container(
                      width: 10.0,
                    ),
                    const Text(
                      "Refiere y Gana",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20.0,
                          fontFamily: "Monserrat",
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Container(
                  height: 10.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 20.0,
                    ),
                    const Text(
                      "Invitar Parcero",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontFamily: "Monserrat",
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 70.0,
                    ),
                    const Text(
                      " ",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Monserrat",
                          fontWeight: FontWeight.bold,
                          color: blue),
                    ),
                    Container(
                      width: 10.0,
                    ),
                  ],
                ),
                Container(
                  height: 5.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 20.0,
                    ),
                    const Text(
                      "Conoce Nuestros\nbeneficios",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontFamily: "Monserrat",
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 50.0,
                    ),
                    const Text(
                      " ",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Monserrat",
                          fontWeight: FontWeight.bold,
                          color: blue),
                    ),
                    Container(
                      width: 10.0,
                    ),
                  ],
                ),
                Container(
                  height: 70.0,
                )
              ],
            ),
            Positioned(bottom: 10, left: 0.0, child: bottomNavBar(context))
          ],
        ));
  }

  Future<Row> stars() async {
    Query calificacionPonderada = FirebaseDatabase.instance
        .ref()
        .child('calificaciones/$usuario/calificacion');
    return calificacionPonderada.get().then((value) => dibujarEstrellas(3.7));
  }

  Row dibujarEstrellas(calificacion) {
    if (calificacion == null) {
      return Row(
        children: [
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          Container(
            width: 20.0,
          ),
          Text(
            calificacionPonderada,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Monserrat",
                fontWeight: FontWeight.bold,
                color: blue),
          ),
        ],
      );
    }

    if (calificacion > 0 && calificacion < 0.5) {
      return Row(
        children: [
          const Icon(Icons.star_border_rounded),
          const Icon(Icons.star_border_rounded),
          const Icon(Icons.star_border_rounded),
          const Icon(Icons.star_border_rounded),
          const Icon(Icons.star_border_rounded),
          Container(
            width: 20.0,
          ),
          Text(
            calificacionPonderada,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Monserrat",
                fontWeight: FontWeight.bold,
                color: blue),
          ),
        ],
      );
    }

    if (calificacion >= 0.5 && calificacion < 1) {
      calificacionPonderada =
          double.parse((calificacion).toStringAsFixed(1)).toString();
      return Row(
        children: [
          const Icon(Icons.star_half_rounded),
          const Icon(Icons.star_border_rounded),
          const Icon(Icons.star_border_rounded),
          const Icon(Icons.star_border_rounded),
          const Icon(Icons.star_border_rounded),
          Container(
            width: 20.0,
          ),
          Text(
            calificacionPonderada,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Monserrat",
                fontWeight: FontWeight.bold,
                color: blue),
          ),
        ],
      );
    }

    if (calificacion >= 1.0 && calificacion < 1.5) {
      calificacionPonderada =
          double.parse((calificacion).toStringAsFixed(1)).toString();
      return Row(
        children: [
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_border_rounded),
          const Icon(Icons.star_border_rounded),
          const Icon(Icons.star_border_rounded),
          const Icon(Icons.star_border_rounded),
          Container(
            width: 20.0,
          ),
          Text(
            calificacionPonderada,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Monserrat",
                fontWeight: FontWeight.bold,
                color: blue),
          ),
        ],
      );
    }

    if (calificacion >= 1.5 && calificacion < 2.0) {
      calificacionPonderada =
          double.parse((calificacion).toStringAsFixed(1)).toString();
      return Row(
        children: [
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_half_rounded),
          const Icon(Icons.star_border_rounded),
          const Icon(Icons.star_border_rounded),
          const Icon(Icons.star_border_rounded),
          Container(
            width: 20.0,
          ),
          Text(
            calificacionPonderada,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Monserrat",
                fontWeight: FontWeight.bold,
                color: blue),
          ),
        ],
      );
    }

    if (calificacion >= 2.0 && calificacion < 2.5) {
      calificacionPonderada =
          double.parse((calificacion).toStringAsFixed(1)).toString();
      return Row(
        children: [
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_border_rounded),
          const Icon(Icons.star_border_rounded),
          const Icon(Icons.star_border_rounded),
          Container(
            width: 20.0,
          ),
          Text(
            calificacionPonderada,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Monserrat",
                fontWeight: FontWeight.bold,
                color: blue),
          ),
        ],
      );
    }

    if (calificacion >= 2.5 && calificacion < 3.0) {
      calificacionPonderada =
          double.parse((calificacion).toStringAsFixed(1)).toString();
      return Row(
        children: [
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_half_rounded),
          const Icon(Icons.star_border_rounded),
          const Icon(Icons.star_border_rounded),
          Container(
            width: 20.0,
          ),
          Text(
            calificacionPonderada,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Monserrat",
                fontWeight: FontWeight.bold,
                color: blue),
          ),
        ],
      );
    }

    if (calificacion >= 3.0 && calificacion < 3.5) {
      calificacionPonderada =
          double.parse((calificacion).toStringAsFixed(1)).toString();
      return Row(
        children: [
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_border_rounded),
          const Icon(Icons.star_border_rounded),
          Container(
            width: 20.0,
          ),
          Text(
            calificacionPonderada,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Monserrat",
                fontWeight: FontWeight.bold,
                color: blue),
          ),
        ],
      );
    }

    if (calificacion >= 3.5 && calificacion < 4.0) {
      calificacionPonderada =
          double.parse((calificacion).toStringAsFixed(1)).toString();
      return Row(
        children: [
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_half_rounded),
          const Icon(Icons.star_border_rounded),
          Container(
            width: 20.0,
          ),
          Text(
            calificacionPonderada,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Monserrat",
                fontWeight: FontWeight.bold,
                color: blue),
          ),
        ],
      );
    }

    if (calificacion >= 4.0 && calificacion < 4.5) {
      calificacionPonderada =
          double.parse((calificacion).toStringAsFixed(1)).toString();
      return Row(
        children: [
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_border_rounded),
          Container(
            width: 20.0,
          ),
          Text(
            calificacionPonderada,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Monserrat",
                fontWeight: FontWeight.bold,
                color: blue),
          ),
        ],
      );
    }

    if (calificacion >= 4.5 && calificacion < 5.0) {
      calificacionPonderada =
          double.parse((calificacion).toStringAsFixed(1)).toString();
      return Row(
        children: [
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_half_rounded),
          Container(
            width: 20.0,
          ),
          Text(
            calificacionPonderada,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Monserrat",
                fontWeight: FontWeight.bold,
                color: blue),
          ),
        ],
      );
    }
    if (calificacion == 5) {
      calificacionPonderada =
          double.parse((calificacion).toStringAsFixed(1)).toString();
      return Row(
        children: [
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          const Icon(Icons.star_rounded),
          Container(
            width: 20.0,
          ),
          Text(
            calificacionPonderada,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Monserrat",
                fontWeight: FontWeight.bold,
                color: blue),
          ),
        ],
      );
    }

    return Row(
      children: const [Icon(Icons.star_rounded)],
    );
  }

  GestureDetector itemMenu(String title, String img) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          SvgPicture.asset(
            img,
            width: 40,
            color: Colors.white,
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                fontFamily: "Monserrat"),
            textAlign: TextAlign.center,
          )
        ],
      ),
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
                color_icon_inicio = blue;
                color_icon_historial = blue;
                color_icon_ingresos = blue;
                color_icon_perfil = blue_dark;
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
