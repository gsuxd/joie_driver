import 'package:joiedriver/pedidos.dart';
import 'package:joiedriver/profile.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'colors.dart';
import 'estatics.dart';
import 'mapa_google.dart';
import 'mapa_secont.dart';
class MapaMenu extends StatefulWidget {
  late double latitude;
  late double longitude;
  MapaMenu({ required double this.latitude, required double this.longitude});
  static const String routeName = '/Register';
  @override
  createState() =>  _MapaMenuState(latitude: latitude, longitude: longitude);
}

class _MapaMenuState extends State<MapaMenu> {
  String state = "Desconectado";
  bool isSwitched = false;
  Color color_icon_inicio = blue_dark;
  Color color_icon_historial = blue;
  Color color_icon_perfil = blue;
  Color color_icon_ingresos = blue;
  bool mensaje_request = false;
  late double latitude;
  late double longitude;
  int count_sms = 0;
  _MapaMenuState({ required double this.latitude, required double this.longitude});

  @override
  Widget build(BuildContext context) {
    if(count_sms == 0){
      count_sms = 1;
      sms(context);
    }

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
          child: Text(state, style: TextStyle(fontFamily: "Monserrat", fontWeight: FontWeight.bold, fontSize: 20.0), textAlign: TextAlign.center,),
        ),
        actions: [ConectSwitch(context)],

      ),
      backgroundColor: Colors.white,
      body:
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height-56,
                child:
                Mapa(x: latitude, y:longitude),),
              Positioned(
                bottom: 10,
                  left: 0,
                  child: bottomNavBar(context)),

              Positioned(
                  bottom: 80,
                  left: 0,
                  child:
                  requestClient(context, "Andrea Guzman", 50.0, "assets/images/estrella5.png", "assets/images/girld2.jpg"),
              ),
            ],
          ),

    );

  }

  Visibility requestClient(BuildContext context, String name, double mount, String rate, String url_img) {
    return Visibility(
                  visible: mensaje_request,
                  child: Container(
                    padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                    width: MediaQuery.of(context).size.width-10,
                    margin: EdgeInsets.only(right: 5.0, left: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all( width: 1.0, color: blue),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 10,
                            ),
                            Row(
                                children: [

                                  CircleAvatar(
                                    backgroundImage: AssetImage(url_img),
                                  ),
                                  Container(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                       name, style: TextStyle(color: Colors.black87, fontFamily: "Monserrat", fontWeight: FontWeight.bold),
                                      ),
                                      Image.asset(
                                        rate,
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ]),
                            Container(
                              width: 10,
                            ),
                            Text(
                              "$mount \$", style: TextStyle(color: Colors.black87, fontFamily: "Monserrat", fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: 10,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 10.0,
                            ),
                            ElevatedButton(onPressed: () {
                              //bool _visible = true;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>

                                  MapaSecont(longitude: longitude, latitude: latitude, isSwitched: isSwitched, state: state,))
                              );
                            },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                padding: EdgeInsets.only(top: 0.0, bottom: 0.0, left: 25.0, right: 25.0),
                                shadowColor: Colors.grey,
                                primary: blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              child: Text(
                                "Aceptar", style: TextStyle(color: Colors.white, fontFamily: "Monserrat", fontWeight: FontWeight.bold),
                              ),

                            ),
                            Container(
                              width: 10.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState((){
                                  mensaje_request = false;
                                });
                            },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                padding: EdgeInsets.only(top: 0.0, bottom: 0.0, left: 25.0, right: 25.0),
                                shadowColor: Colors.grey,
                                primary: Colors.black38,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              child: Text(
                                "Ignorar", style: TextStyle(color: Colors.white, fontFamily: "Monserrat", fontWeight: FontWeight.bold),
                              ),

                            ),
                            Container(
                              width: 10.0,
                            ),
                          ],
                        ),
                      ],
                    ),
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

  Widget bottomNavBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
        child: Row(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {
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
              padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              primary: color_icon_ingresos,
              shape: CircleBorder(),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile()));
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
