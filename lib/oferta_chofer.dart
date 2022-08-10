import 'dart:async';
import 'package:joiedriver/pedidos.dart';
import 'package:joiedriver/profile.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'colors.dart';
import 'estatics.dart';

class Oferta extends StatefulWidget {
  const Oferta({Key? key}) : super(key: key);

  @override
  createState() => _OfertaState();
}

class _OfertaState extends State<Oferta> {
  Color color_icon_inicio = blue_dark;
  Color color_icon_historial = blue;
  Color color_icon_perfil = blue;
  Color color_icon_ingresos = blue;
  String state = "Bogota";
  bool isSwitched = false;

  double progreso = 1;
  int duracion = 5000;
  bool solicitar = true;

  void startTime() {
    Timer.periodic(Duration(milliseconds: duracion), (timer) {
      setState(() {
        if (progreso <= 0) {
          solicitar = false;
          timer.cancel();
        } else {
          progreso -= 0.03334;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    startTime();
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
        backgroundColor: Colors.black87,
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.only(bottom: 70.0),
              children: [
                Container(
                  height: 45.0,
                ),
                Visibility(
                  visible: solicitar,
                  child: ofertaItem(
                      context,
                      "Vicente Rojas",
                      "assets/images/estrella5.png",
                      50.0,
                      3,
                      "assets/images/girld2.jpg"),
                ),
                Visibility(
                  visible: solicitar,
                  child: ofertaItem(
                      context,
                      "Vicente Rojas",
                      "assets/images/estrella5.png",
                      50.0,
                      3,
                      "assets/images/girld2.jpg"),
                ),
                Visibility(
                  visible: solicitar,
                  child: ofertaItem(
                      context,
                      "Vicente Rojas",
                      "assets/images/estrella5.png",
                      50.0,
                      3,
                      "assets/images/girld2.jpg"),
                ),
                Visibility(
                  visible: solicitar,
                  child: ofertaItem(
                      context,
                      "Vicente Rojas",
                      "assets/images/estrella5.png",
                      50.0,
                      3,
                      "assets/images/girld2.jpg"),
                ),
              ],
            ),
            Positioned(bottom: 10, left: 0.0, child: bottomNavBar(context)),
            Positioned(
                top: 0,
                left: 0.0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10.0),
                    color: Colors.black,
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Ofertas de Conductores",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Monserrat",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )))),
          ],
        ));
  }

  Container ofertaItem(BuildContext context, String name, String rate,
      double price, int min, String url_img) {
    return Container(
      margin:
          const EdgeInsets.only(top: 0.0, bottom: 5.0, left: 10.0, right: 10.0),
      height: 120,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            child: LinearProgressIndicator(
              value: progreso,
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation(blue),
            ),
          ),
          Container(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 10.0,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(url_img),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontFamily: "Monserrat",
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      Image.asset(
                        rate,
                        height: 15,
                      )
                    ],
                  )
                ],
              ),
              Container(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$price \$",
                    style: const TextStyle(
                        fontFamily: "Monserrat",
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$min min",
                    style: const TextStyle(
                        fontFamily: "Monserrat",
                        color: blue,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                width: 10.0,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 10.0,
              ),
              SizedBox(
                width: 110,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                      //side: BorderSide(width: 1, color: Colors.black54),
                    ),
                  ),
                  child: const Text(
                    "Declinar",
                    style: TextStyle(
                        fontFamily: "Monserrat",
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                width: 10.0,
              ),
              SizedBox(
                width: 110,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: blue,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                      //side: BorderSide(width: 1, color: Colors.black54),
                    ),
                  ),
                  child: const Text(
                    "Aceptar",
                    style: TextStyle(
                        fontFamily: "Monserrat",
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                width: 10.0,
              ),
            ],
          ),
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
            onPressed: () {},
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
}
