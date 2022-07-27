import 'package:joiedriver/mapa_secont_usuario.dart';
import 'package:joiedriver/pedidos.dart';
import 'package:joiedriver/perfil_usuario.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'asistencia_tecnica.dart';
import 'colors.dart';
import 'mapa_google_usuario.dart';
class MapaMenuUsuario extends StatefulWidget {
  late double latitude;
  late double longitude;
  MapaMenuUsuario({ required double this.latitude, required double this.longitude});
  static const String routeName = '/Register';
  @override
  createState() =>  _MapaMenuState(latitude: latitude, longitude: longitude);
}

class _MapaMenuState extends State<MapaMenuUsuario> {
  String state = "Bogotá";
  bool isSwitched = false;
  Color color_icon_inicio = blue_dark;
  Color color_icon_historial = blue;
  Color color_icon_perfil = blue;
  Color color_icon_ingresos = blue;
  bool mensaje_request = false;
  late double latitude;
  late double longitude;
  late int notificacion_reporte;
  _MapaMenuState({ required double this.latitude, required double this.longitude, int this.notificacion_reporte = 0 });

  @override
  Widget build(BuildContext context) {
    if(notificacion_reporte == 1){
      notificacion_reporte = 0;
      sms(context);
    }
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
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-56,
            child:
            MapaUsuario(x: latitude, y:longitude),),
          Positioned(
              bottom: 10,
              left: 0,
              child: bottomNavBar(context)),

          Positioned(
            bottom: 100,
            left: (MediaQuery.of(context).size.width/2)-80,
            child: requestClient(context,),
          ),
          Positioned(
            bottom: 70,
            left: (MediaQuery.of(context).size.width/2)-65,
            child: Center(
              child: Text("Solicitar Viaje", style: TextStyle(color: blue, fontFamily: "Monserrat", fontSize: 18.0),),
            ),
          ),

          Positioned(
            bottom: 20.0,
            left: 0.0,
            child: alert()),
        ],
      ),

    );

  }

  Widget alert(){
    return Visibility(
      visible: mensaje_request,
      child: Container(
        height: 110.0,
        width: MediaQuery.of(context).size.width-20,
        padding: EdgeInsets.only(top: 10, bottom: 20.0, left: 10, right: 0.0),
        margin: EdgeInsets.only(right: 10.0, left: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(width: 1, color: blue),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child:
                  Align(
                      alignment: Alignment.topRight,
                      child:  IconButton(onPressed: (){
                        mensaje_request = false;
                        setState(() {

                        });
                      }, icon: Icon(Icons.cancel_outlined, color: Colors.red, size: 30,), )
                  ),
                ),

                Container(
                  height: 10.0,
                  width: MediaQuery.of(context).size.width-32,
                ),
                Row(
                  children: [
                    Icon(Icons.notifications_none_outlined, color: blue,),
                    Text("Asistencia Tecnica", style: TextStyle(color: blue, fontFamily: "Monserrat",fontWeight: FontWeight.bold, ),)
                  ],
                ),
                Container(
                  height: 5.0,
                ),
                Text("Su reporte ha sido recibido, en breve atenderemos su problema", style: TextStyle(color: Colors.black87, fontFamily: "Monserrat",  ),),
              ],
            )
          ],
        ),
      ),
    );
  }

  GestureDetector requestClient(BuildContext context,) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MapaSecontUsuario(state: state, longitude: longitude, latitude: latitude,)));
      },
      child: Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
        width: 140,
        height: 140,
        margin: EdgeInsets.only(right: 5.0, left: 5.0),
        decoration: BoxDecoration(
          color: circle,
          shape: BoxShape.circle,
          border: Border.all( width: 4.0, color: blue),
        ),
        child: Center(
              child: SvgPicture.asset(
                "assets/images/historial.svg",
                width: 130,
                color: blue,

              ),
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

  Future<void> sms(context) {
    // Imagine that this function is fetching user info from another service or database.
    return Future.delayed(
        const Duration(milliseconds: 4800),
            () => setState((){
          mensaje_request = true;
        }));
  }

}