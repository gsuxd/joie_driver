import 'package:joiedriver/pedido_time.dart';
import 'package:joiedriver/pedidos.dart';
import 'package:joiedriver/profile.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'colors.dart';
import 'estatics.dart';
import 'mapa_principal.dart';

class Pedido extends StatefulWidget {
  @override
  createState() => _PedidoState();
}

class _PedidoState extends State<Pedido> {
  Color color_icon_inicio = blue;
  Color color_icon_historial = blue_dark;
  Color color_icon_perfil = blue;
  Color color_icon_ingresos = blue;
  String state = "Desconectado";
  bool isSwitched = false;
  String puntoA = "Centro Comercial el Loco";
  String puntoB = "El Trebol, Avenida Buena Suerte";
  String url_img = "https://picsum.photos/seed/913/400";
  double total_cliente = 50.00;
  double total = 50.00;
  Color selelct = Colors.black87;
  Color selelct1 = Colors.white;
  Color selelct2 = Colors.white;
  Color selelct3 = Colors.white;
  Color selelct4 = Colors.white;
  Color selelct5 = Colors.white;

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
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                        color: Colors.black87, fontFamily: "Monserrat"),
                  ),
                ),
                Image.asset(
                  "assets/images/mapa.png",
                  width: MediaQuery.of(context).size.width - 40,
                ),
                Container(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
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
                      width: 5.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 10.0,
                              backgroundColor: blue_dark,
                              backgroundImage:
                                  AssetImage("assets/images/A.png"),
                            ),
                            Container(
                              width: 5.0,
                            ),
                            Text(
                              puntoA,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "Monserrat"),
                            )
                          ],
                        ),
                        Container(
                          height: 2.0,
                        ),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 10.0,
                              backgroundColor: Colors.green,
                              backgroundImage:
                                  AssetImage("assets/images/B.png"),
                            ),
                            Container(
                              width: 5.0,
                            ),
                            Text(
                              puntoB,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "Monserrat"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PedidosTime()));
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
                    "Aceptar por $total \$",
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Monserrat",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 10.0,
                ),
                const Center(
                  child: Text(
                    "Ofrezca su precio de Viaje",
                    style: TextStyle(
                        color: Colors.black87, fontFamily: "Monserrat"),
                  ),
                ),
                Container(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 2.0,
                    ),
                    SizedBox(
                      width: 60.0,
                      height: 30.0,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            total = total_cliente;
                            selelct1 = Colors.white;
                            selelct = Colors.black87;
                            selelct2 = Colors.white;
                            selelct3 = Colors.white;
                            selelct4 = Colors.white;
                            selelct5 = Colors.white;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          // padding: EdgeInsets.only(top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
                          shadowColor: Colors.grey,
                          primary: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                        child: Text(
                          "$total_cliente \$",
                          style: TextStyle(
                              color: selelct,
                              fontFamily: "Monserrat",
                              fontSize: 8.0),
                        ),
                      ),
                    ),
                    Container(
                      width: 2.0,
                    ),
                    percent(0.05, "5", 1, selelct1),
                    Container(
                      width: 2.0,
                    ),
                    percent(0.10, "10", 2, selelct2),
                    Container(
                      width: 2.0,
                    ),
                    percent(0.20, "20", 3, selelct3),
                    Container(
                      width: 2.0,
                    ),
                    percent(0.30, "30", 4, selelct4),
                    Container(
                      width: 2.0,
                    ),
                    percent(0.50, "50", 5, selelct5),
                    Container(
                      width: 2.0,
                    ),
                  ],
                ),
                Container(
                  height: 60.0,
                ),
              ],
            ),
            Positioned(bottom: 10, left: 0.0, child: bottomNavBar(context))
          ],
        ));
  }

  Container percent(
      double porcetaje, String porcentajeS, int select, Color color_select) {
    return Container(
        width: 52.0,
        height: 30.0,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              total = total_cliente + total_cliente * porcetaje;
              if (select == 1) {
                selelct1 = Colors.black87;
                selelct = Colors.white;
                selelct2 = Colors.white;
                selelct3 = Colors.white;
                selelct4 = Colors.white;
                selelct5 = Colors.white;
              } else if (select == 2) {
                selelct1 = Colors.white;
                selelct = Colors.white;
                selelct2 = Colors.black87;
                selelct3 = Colors.white;
                selelct4 = Colors.white;
                selelct5 = Colors.white;
              } else if (select == 3) {
                selelct1 = Colors.white;
                selelct = Colors.white;
                selelct2 = Colors.white;
                selelct3 = Colors.black87;
                selelct4 = Colors.white;
                selelct5 = Colors.white;
              } else if (select == 4) {
                selelct1 = Colors.white;
                selelct = Colors.white;
                selelct2 = Colors.white;
                selelct3 = Colors.white;
                selelct4 = Colors.black87;
                selelct5 = Colors.white;
              } else if (select == 5) {
                selelct1 = Colors.white;
                selelct = Colors.white;
                selelct2 = Colors.white;
                selelct3 = Colors.white;
                selelct4 = Colors.white;
                selelct5 = Colors.black87;
              }
            });
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            //padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
            shadowColor: Colors.grey,
            primary: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: Text(
            "$porcentajeS%",
            style: TextStyle(
                color: color_select, fontFamily: "Monserrat", fontSize: 9),
          ),
        ));
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Statics()));
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
