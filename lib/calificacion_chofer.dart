import 'package:joiedriver/pedidos.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'calificacion_estrellas.dart';
import 'calificacion_estrellas_dao.dart';
import 'colors.dart';
import 'estatics.dart';
import 'mapa_principal.dart';

class CalificacionChofer extends StatefulWidget {


  const CalificacionChofer({Key? key}) : super(key: key);
  @override
  createState() =>  _CalificacionState();
}

class _CalificacionState extends State<CalificacionChofer> {
  String usuarioReceptor = "-----usuarioPruebaCho------";
  double calificacion = 0.0;
  String state = "Desconectado";
  bool isSwitched = false;
  Color color_icon_inicio = blue_dark;
  Color color_icon_historial = blue;
  Color color_icon_perfil = blue;
  Color color_icon_ingresos = blue;
  String estrella = "assets/images/estrella_vacia.svg";
  String estrella2 = "assets/images/estrella_vacia.svg";
  String estrella3 = "assets/images/estrella_vacia.svg";
  String estrella4 = "assets/images/estrella_vacia.svg";
  String estrella5 = "assets/images/estrella_vacia.svg";
  String animacion = "assets/images/pensando.gif";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: blue,
          leading:
          GestureDetector(
            onTap: (){},
            child: SvgPicture.asset(
              "assets/images/perfil_principal.svg",
              width: 24,
              color: Colors.white,
            ),
          ),
          title: Center(
            child: Text(state, style: const TextStyle(fontFamily: "Monserrat", fontWeight: FontWeight.bold, fontSize: 20.0), textAlign: TextAlign.center,),
          ),
          actions: [ConectSwitch(context)],

        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(

              children: [
                Container(
                  height: 30.0,
                ),
                const Center(
                  child: Text("Califica a tu conductor", style: TextStyle(color: blue, fontFamily: "Monserrat",fontWeight: FontWeight.bold, fontSize: 18.0),),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
                  margin: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                    border: Border.all( width: 2.0, color: blue_dark),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("assets/images/girld2.jpg"),
                      ),
                      Container(
                        width: 10.0,
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            estrella = "assets/images/estrella.svg";
                            estrella2 = "assets/images/estrella_vacia.svg";
                            estrella3 = "assets/images/estrella_vacia.svg";
                            estrella4 = "assets/images/estrella_vacia.svg";
                            estrella5 = "assets/images/estrella_vacia.svg";
                            animacion = "assets/images/molesto.gif";
                            calificacion = 1.0;
                          });
                        },
                        child: SvgPicture.asset(estrella, color: estrella_color, height: 25.0,),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            estrella = "assets/images/estrella.svg";
                            estrella2 = "assets/images/estrella.svg";
                            estrella3 = "assets/images/estrella_vacia.svg";
                            estrella4 = "assets/images/estrella_vacia.svg";
                            estrella5 = "assets/images/estrella_vacia.svg";
                            animacion = "assets/images/molesto.gif";
                            calificacion = 2.0;
                          });
                        },
                        child: SvgPicture.asset(estrella2, color: estrella_color, height: 25.0,),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            estrella = "assets/images/estrella.svg";
                            estrella2 = "assets/images/estrella.svg";
                            estrella3 = "assets/images/estrella.svg";
                            estrella4 = "assets/images/estrella_vacia.svg";
                            estrella5 = "assets/images/estrella_vacia.svg";
                            animacion = "assets/images/moderado.gif";
                            calificacion = 3.0;
                          });
                        },
                        child: SvgPicture.asset(estrella3, color: estrella_color, height: 25.0,),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            estrella = "assets/images/estrella.svg";
                            estrella2 = "assets/images/estrella.svg";
                            estrella3 = "assets/images/estrella.svg";
                            estrella4 = "assets/images/estrella.svg";
                            estrella5 = "assets/images/estrella_vacia.svg";
                            animacion = "assets/images/feliz.gif";
                            calificacion = 4.0;
                          });
                        },
                        child: SvgPicture.asset(estrella4, color: estrella_color, height: 25.0,),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            estrella = "assets/images/estrella.svg";
                            estrella2 = "assets/images/estrella.svg";
                            estrella3 = "assets/images/estrella.svg";
                            estrella4 = "assets/images/estrella.svg";
                            estrella5 = "assets/images/estrella.svg";
                            animacion = "assets/images/feliz.gif";
                            calificacion = 5.0;
                          });
                        },
                        child: SvgPicture.asset(estrella5, color: estrella_color, height: 25.0,),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 0.0,
                ),
                Center(
                  child: Image.asset(animacion, width: 70,),
                ),
                Container(
                  height: 30.0,
                ),
                Center(
                  child:
                  SizedBox(
                    width: 150,
                    child:   ElevatedButton(onPressed: (){
                      if(calificacion != 0.0) {
                        Query calificacionPonderada = FirebaseDatabase.instance
                            .ref()
                            .child(
                            'calificaciones/$usuarioReceptor/calificacion');
                        calificacionPonderada.get().then((value) =>
                            obtenerCalificacion(value.value));
                      }
                    },
                        style: ElevatedButton.styleFrom(
                          primary: blue,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0),
                            //side: BorderSide(width: 1, color: Colors.black54),
                          ),
                        ),
                        child: const Text("Siguiente", style: TextStyle(color: Colors.white, fontFamily: "Monserrat",fontWeight: FontWeight.bold, fontSize: 18.0),)
                    ),
                  ),
                ),
                Container(
                  height: 30.0,
                ),
                Center(
                  child:
                  SizedBox(
                    width: 200,
                    child:   ElevatedButton(onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0),
                            //side: BorderSide(width: 1, color: Colors.black54),
                          ),
                        ),
                        child: const Text("Reportar queja", style: TextStyle(color: Colors.white, fontFamily: "Monserrat",fontWeight: FontWeight.bold, fontSize: 18.0),)
                    ),
                  ),
                ),

                Container(
                  height: 70.0,
                ),
              ],
            ),
            Positioned(
                bottom: 10,
                left: 0.0,
                child: bottomNavBar(context))
          ],
        )
    ) ;

  }

  obtenerCalificacion(value){
    value ??= 0;
    double calificacionAnterior = value as double;

    Query nCalificacionPonderada = FirebaseDatabase.instance
        .ref()
        .child(
        'calificaciones/$usuarioReceptor/calificaciones');
    nCalificacionPonderada.get().then((snapshot) =>
        ponderarCalificaciones(snapshot, calificacionAnterior));


  }

  ponderarCalificaciones(snapshot, calificacionAnterior){

    Map<dynamic, dynamic> json = {};

    if(snapshot.value != null){

      json = snapshot.value as Map<dynamic, dynamic>;
    }


    //print(json.length);
    num calificacionPonderada = (json.length)*calificacionAnterior;
    double calificacionPonderadaNew = calificacionPonderada + calificacion;
    double calificacionFinal = calificacionPonderadaNew / (json.length + 1);
    calificacionFinal = double.parse((calificacionFinal).toStringAsFixed(3));

    CalificacionEstrella calificacionBase = CalificacionEstrella(
        usuarioReceptor: usuarioReceptor,
        usuarioEmisor: 'usuarioPrueba',
        fecha: DateTime.now(),
        calificacion: calificacionFinal, calificacionIndividual: calificacion);
    CalificacionEstrellaDao.guardarMensaje(
        calificacionBase);
  }

  GestureDetector itemMenu( String title, String img) {
    return GestureDetector(
      onTap: (){},
      child: Column(
        children: [
          SvgPicture.asset(
            img,
            width: 40,
            color: Colors.white,
          ),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, fontFamily: "Monserrat"), textAlign: TextAlign.center,)
        ],
      ),
    );
  }

  Widget bottomNavBar(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: ()   async {
            Future<Position> coord =  _determinePosition();
            double longitude = await coord.then((value) => value.longitude);
            double latitude = await coord.then((value) => value.latitude);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MapaMenu(longitude: longitude, latitude: latitude,)));
          },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
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
          ElevatedButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Pedidos()));
          },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
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
          ElevatedButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Statics()));
          },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
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
          ElevatedButton(onPressed: () {
            setState(() {
              color_icon_inicio = blue;
              color_icon_historial = blue;
              color_icon_ingresos = blue;
              color_icon_perfil = blue_dark;
            });
          },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
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

  Widget ConectSwitch(BuildContext context) {
    return

      Switch(

        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
            if(state == "Desconectado"){
              state = "Conectado";
            }else{
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
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  }


}