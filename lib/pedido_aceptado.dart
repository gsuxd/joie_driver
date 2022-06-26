import 'dart:async';
import 'package:joiedriver/pedidos.dart';
import 'package:joiedriver/perfil_usuario.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'asistencia_tecnica.dart';
import 'colors.dart';
import 'confirmar_cancelar_viaje_usuario.dart';
import 'mapa_google_usuario.dart';
import 'mapa_principal_usuario.dart';


class PedidoAceptado extends StatefulWidget {
  late double latitude;
  late double longitude;
  late String state;

  PedidoAceptado({ required double this.latitude, required double this.longitude, required this.state});
  static const String routeName = '/Register';
  @override
  createState() =>  _MapaSecontState(latitude: latitude, longitude: longitude, state: state,);
}

class _MapaSecontState extends State<PedidoAceptado> {
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
  bool solicitar = true;
  String name = "Vicente Rojas";
  double price = 90.00;
  int time = 3;
  String codigo = "GBD-53-4E";
  double progreso = 0;
  int duracion = 5000;

  void startTime(){
    Timer.periodic(Duration(milliseconds: duracion), (timer) {
      setState(() {
        if(progreso >= 1){
          solicitar = false;
          timer.cancel();
        }else{
          progreso += 0.03334;
        }
      });
    });
  }

  _MapaSecontState({ required double this.latitude, required double this.longitude , required this.state});
  @override
  Widget build(BuildContext context) {
    startTime();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: blue,
          leading:
          Container(
            padding: EdgeInsets.all(5.0),
            child: GestureDetector(
                onTap: (){},
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/images/girld2.jpg"),
                )
            ),
          ),
          title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){},
                  child: SvgPicture.asset(
                    "assets/images/location.svg",
                    width: 30,
                    color: Colors.white,

                  ),
                ),
                Container(
                  width: 5.0,
                ),
                Text(state, style: TextStyle(fontFamily: "Monserrat", fontWeight: FontWeight.bold, fontSize: 25.0), textAlign: TextAlign.center,),]
          ),
          actions: [GestureDetector(
            onTap: (){},
            child: SvgPicture.asset(
              "assets/images/share.svg",
              width: 30,
              color: Colors.white,

            ),
          ), Container(
            width: 10.0,
          ),],

        ),
        backgroundColor: Colors.white,
        body:
        Stack(
          children: [
            MapaUsuario(x: latitude, y:longitude),
            Positioned(
                bottom: 10,
                left: 0.0,
                child: bottomNavBar(context)),

            top(context),


            Visibility(
                visible: solicitar,
                child: Positioned(
                  bottom: 100,
                  left: (MediaQuery.of(context).size.width/2)-80,
                  child: requestClient(context,),
                )),
            Visibility(
                visible: solicitar,
                child: Positioned(
                  bottom: 100,
                  left: (MediaQuery.of(context).size.width/2)-80,
                  child:
                  Container(
                    width: 140,
                    height: 140,
                    margin: EdgeInsets.only(right: 5.0, left: 5.0),
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 6.0,
                      backgroundColor: Colors.red,
                      valueColor: AlwaysStoppedAnimation(Colors.grey),
                      value: progreso,
                    ),
                  ),
                )),

          ],
        )

    );
  }

  GestureDetector requestClient(BuildContext context,) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PedidosCancelarConfirmarUsuario()));
      },
      child: Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
        width: 140,
        height: 140,
        margin: EdgeInsets.only(right: 5.0, left: 5.0),
        decoration: BoxDecoration(
          color: circle_regresive,
          shape: BoxShape.circle,
          border: Border.all( width: 2.0, color: blue),
        ),
        child: Center(
          child: SvgPicture.asset(
            "assets/images/cancelar_carrera.svg",
            width: 100,
            color: Colors.red,

          ),
        ),
      ),
    );
  }

  Positioned top(BuildContext context) {
    return Positioned(
              top: -80,
              left: 0.0,
              child:
              Container(
                width: MediaQuery.of(context).size.width,
                height: 230.0,
                child: ListView(
                  reverse: false,
                  children: [
                    Container(
                      height: 75.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: blue),
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 10.0,
                          ),
                          Center(
                            child: Text("$name Acepto su Pedido", style: TextStyle(color: Colors.black87, fontFamily: "Monserrat"), textAlign: TextAlign.center,)
                            ,
                          ),
                          Center(
                            child: Text("Por $price \$ llegara en $time min", style: TextStyle(color: Colors.black87, fontFamily: "Monserrat"), textAlign: TextAlign.center,),
                          ),
                          Container(
                            height: 10.0,
                          ),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: blue),
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              width: 100,
                              child: Text("$codigo", style: TextStyle(color: Colors.grey, fontFamily: "Monserrat"), textAlign: TextAlign.center,),
                            ),
                          ),
                          Container(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 10.0,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage("assets/images/girld2.jpg"),
                                  ),
                                  Container(
                                    width: 5.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("$name", style: TextStyle(color: Colors.grey, fontFamily: "Monserrat"),),
                                      Container(
                                        height: 5.0,
                                      ),
                                      Image.asset("assets/images/estrella5.png", height: 15.0,)
                                    ],
                                  ),
                                ],
                              ),

                              Container(
                                width: 10.0,
                              ),
                              ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onPrimary: Colors.white,
                                  shape: CircleBorder(),
                                  elevation: 0,
                                  padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
                                ),
                                child: SvgPicture.asset(
                                  "assets/images/llamar.svg",
                                  height: 40,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                width: 10.0,
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 75.0,
                    ),
                  ],
                ),
              ),
              );
  }

  Widget bottomNavBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MapaMenuUsuario(latitude: latitude, longitude: longitude,)));
          },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              primary: color_icon_inicio,
              shape: CircleBorder(),
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
          ElevatedButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Pedidos()));
          },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              primary: color_icon_historial,
              shape: CircleBorder(),
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
          ElevatedButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AsistenciaTecnicaUsuario()));
          },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              primary: color_icon_ingresos,
              shape: CircleBorder(),
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
          ElevatedButton(onPressed: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PerfilUsuario()));
            });

          },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              primary: color_icon_perfil,
              shape: CircleBorder(),
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