import 'package:joiedriver/pedido_aceptado.dart';
import 'package:joiedriver/pedidos.dart';
import 'package:joiedriver/perfil_usuario.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;
import 'asistencia_tecnica.dart';
import 'colors.dart';
import 'mapa_google_usuario.dart';
import 'mapa_principal_usuario.dart';

class MapaSecontUsuario extends StatefulWidget {
  late double latitude;
  late double longitude;
  late String state;

  MapaSecontUsuario(
      {required double this.latitude,
      required double this.longitude,
      required this.state});

  static const String routeName = '/Register';

  @override
  createState() => _MapaSecontState(
        latitude: latitude,
        longitude: longitude,
        state: state,
      );
}

class _MapaSecontState extends State<MapaSecontUsuario> {
  late double latitude;
  late double longitude;
  late String state;
  Color color_icon_inicio = blue_dark;
  Color color_icon_historial = blue;
  Color color_icon_perfil = blue;
  Color color_icon_ingresos = blue;
  Color colorPuntoB = Colors.grey;
  Color colorPrecio = Colors.grey;
  Color colorPasajero = Colors.grey;
  Color colorEspecial = Colors.grey;
  Color colorLabel = Colors.black38;
  Color colorLabel2 = Colors.black38;
  Color colorLabel3 = Colors.black38;
  Color colorLabel4 = Colors.black38;
  bool solicitar = false;

  _MapaSecontState(
      {required double this.latitude,
      required double this.longitude,
      required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: blue,
          leading: Container(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
                onTap: () {},
                child: const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/images/girld2.jpg"),
                )),
          ),
          title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                "assets/images/location.svg",
                width: 30,
                color: Colors.white,
              ),
            ),
            Container(
              width: 5.0,
            ),
            Text(
              state,
              style: const TextStyle(
                  fontFamily: "Monserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
          ]),
          actions: [
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                "assets/images/share.svg",
                width: 30,
                color: Colors.white,
              ),
            ),
            Container(
              width: 10.0,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            buildCustomScrollView(),
            Positioned(bottom: 10, left: 0.0, child: bottomNavBar(context))
          ],
        ));
  }

  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: false,
      delegate: _SliverAppBarDelegate(
        minHeight: 260.0,
        maxHeight: 340.0,
        child: MapaUsuario(x: latitude, y: longitude),
      ),
    );
  }

  CustomScrollView buildCustomScrollView() {
    return CustomScrollView(
      slivers: <Widget>[
        makeHeader('Mapa'),
        SliverGrid.count(
          childAspectRatio: 0.85,
          crossAxisCount: 1,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(
                  top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightBlue.withOpacity(0.8),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Column(
                children: [
                  Container(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/puntoA.svg",
                        width: 30,
                        color: blue,
                      ),
                      Container(
                        width: 10.0,
                      ),
                      const Text(
                        "Plaza Bolivar Sabana Grande",
                        style: TextStyle(
                            color: Colors.black45,
                            fontFamily: "Monserrat",
                            fontSize: 12),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    height: 2,
                    color: Colors.black54,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/puntoB.svg",
                        width: 30,
                        color: colorPuntoB,
                      ),
                      Container(
                        width: 10.0,
                      ),
                      TextField(
                        cursorHeight: 12.0,
                        onTap: () {
                          setState(() {
                            if (colorLabel == Colors.black38) {
                              colorLabel = Colors.transparent;
                            }
                          });
                        },
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        onChanged: (text) {
                          setState(() {
                            if (text.isNotEmpty) {
                              colorPuntoB = blue;
                            } else {
                              colorPuntoB = Colors.grey;
                            }
                            if (colorPuntoB == blue &&
                                colorPasajero == blue &&
                                colorPrecio == blue) {
                              solicitar = true;
                            } else {
                              solicitar = false;
                            }
                          });
                        },
                        style: const TextStyle(
                            color: Colors.black45,
                            fontFamily: "Monserrat",
                            fontSize: 12),
                        decoration: InputDecoration(
                          labelText: 'Destino',
                          labelStyle: TextStyle(
                              color: colorLabel,
                              fontFamily: "Monserrat",
                              fontSize: 12),
                          //border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(15.0)), borderSide: BorderSide(color: Colors.white, width: 2),),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 2,
                    color: Colors.black54,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/tarifa.svg",
                        width: 30,
                        color: colorPrecio,
                      ),
                      Container(
                        width: 10.0,
                      ),
                      TextField(
                        cursorHeight: 12.0,
                        onTap: () {
                          setState(() {
                            if (colorLabel2 == Colors.black38) {
                              colorLabel2 = Colors.transparent;
                            }
                          });
                        },
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            if (text.isNotEmpty) {
                              colorPrecio = blue;
                            } else {
                              colorPrecio = Colors.grey;
                            }
                            if (colorPuntoB == blue &&
                                colorPasajero == blue &&
                                colorPrecio == blue) {
                              solicitar = true;
                            } else {
                              solicitar = false;
                            }
                          });
                        },
                        style: const TextStyle(
                            color: Colors.black45,
                            fontFamily: "Monserrat",
                            fontSize: 12),
                        decoration: InputDecoration(
                          labelText: 'Precio de Oferta',
                          labelStyle: TextStyle(
                              color: colorLabel2,
                              fontFamily: "Monserrat",
                              fontSize: 12),
                          //border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(15.0)), borderSide: BorderSide(color: Colors.white, width: 2),),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 2,
                    color: Colors.black54,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/n_pasajeros.svg",
                        width: 30,
                        color: colorPasajero,
                      ),
                      Container(
                        width: 10.0,
                      ),
                      TextField(
                        cursorHeight: 12.0,
                        onTap: () {
                          setState(() {
                            if (colorLabel3 == Colors.black38) {
                              colorLabel3 = Colors.transparent;
                            }
                          });
                        },
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            if (text.isNotEmpty) {
                              colorPasajero = blue;
                            } else {
                              colorPasajero = Colors.grey;
                            }
                            if (colorPuntoB == blue &&
                                colorPasajero == blue &&
                                colorPrecio == blue) {
                              solicitar = true;
                            } else {
                              solicitar = false;
                            }
                          });
                        },
                        style: const TextStyle(
                            color: Colors.black45,
                            fontFamily: "Monserrat",
                            fontSize: 12),
                        decoration: InputDecoration(
                          labelText: 'Numero de Pasajeros',
                          labelStyle: TextStyle(
                              color: colorLabel3,
                              fontFamily: "Monserrat",
                              fontSize: 12),
                          //border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(15.0)), borderSide: BorderSide(color: Colors.white, width: 2),),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 2,
                    color: Colors.black54,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/especial.svg",
                        width: 30,
                        color: colorEspecial,
                      ),
                      Container(
                        width: 10.0,
                      ),
                      TextField(
                        cursorHeight: 12.0,
                        onTap: () {
                          setState(() {
                            if (colorLabel4 == Colors.black38) {
                              colorLabel4 = Colors.transparent;
                            }
                          });
                        },
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        onChanged: (text) {
                          setState(() {
                            if (text.isNotEmpty) {
                              colorEspecial = blue;
                            } else {
                              colorEspecial = Colors.grey;
                            }
                            if (colorPuntoB == blue &&
                                colorPasajero == blue &&
                                colorPrecio == blue) {
                              solicitar = true;
                            } else {
                              solicitar = false;
                            }
                          });
                        },
                        style: const TextStyle(
                            color: Colors.black45,
                            fontFamily: "Monserrat",
                            fontSize: 12),
                        decoration: InputDecoration(
                          labelText: 'Necesidad Especial',
                          labelStyle: TextStyle(
                              color: colorLabel4,
                              fontFamily: "Monserrat",
                              fontSize: 12),
                          //border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(15.0)), borderSide: BorderSide(color: Colors.white, width: 2),),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 2,
                    color: Colors.black54,
                    margin: const EdgeInsets.only(bottom: 5),
                  ),
                  Visibility(
                      visible: solicitar,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PedidoAceptado(
                                          state: state,
                                          longitude: longitude,
                                          latitude: latitude,
                                        )));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: blue,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                              side: const BorderSide(
                                  width: 1, color: Colors.black54),
                            ),
                          ),
                          child: Container(
                              padding: const EdgeInsets.only(
                                  right: 5.0,
                                  left: 5.0,
                                  top: 15.0,
                                  bottom: 15.0),
                              child: const Text(
                                "Solicitar Viaje",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Monserrat"),
                              )))),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  SizedBox bottomNavBar(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MapaMenuUsuario(
                            latitude: latitude,
                            longitude: longitude,
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
              "assets/images/historial2.svg",
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
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AsistenciaTecnicaUsuario()));
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
              "assets/images/asistencia_tecnica.svg",
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
                    MaterialPageRoute(builder: (context) => PerfilUsuario()));
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
