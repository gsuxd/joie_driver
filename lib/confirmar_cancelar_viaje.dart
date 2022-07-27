import 'package:joiedriver/pedidos.dart';
import 'package:joiedriver/perfil_usuario.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';

import 'asistencia_tecnica.dart';
import 'colors.dart';
import 'estatics.dart';
import 'mapa_principal_usuario.dart';

class PedidosCancelarConfirmar extends StatefulWidget {
  @override
  createState() =>  _PedidosState();
}

class _PedidosState extends State<PedidosCancelarConfirmar> {
  Color color_icon_inicio = blue_dark;
  Color color_icon_historial = blue;
  Color color_icon_perfil = blue;
  Color color_icon_ingresos = blue;
  String state = "Bogota";
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned(
                bottom: 0.0,
                left: 0.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(35.0), topLeft: Radius.circular(35.0)),
                    color: Colors.white,
                  ),
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 20,
                      ),
                      Text("Porque?", style: TextStyle(color: Colors.black87, fontFamily: "Monserrat"),),
                      Container(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width-20,
                        child: ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            primary: blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                              //side: BorderSide(width: 1, color: Colors.black54),
                            ),
                          ),
                          child: Text("Espere demasiado al conductor", style: TextStyle(fontFamily: "Monserrat"),),
                        ),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width-20,
                        child: ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            primary: blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                              //side: BorderSide(width: 1, color: Colors.black54),
                            ),
                          ),
                          child: Text("Ya no necesito un viaje", style: TextStyle(fontFamily: "Monserrat"),),
                        ),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width-20,
                        child: ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            primary: blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                              //side: BorderSide(width: 1, color: Colors.black54),
                            ),
                          ),
                          child: Text("El conductor pidio cancelarlo", style: TextStyle(fontFamily: "Monserrat"),),
                        ),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width-20,
                        child: ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            primary: blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                              //side: BorderSide(width: 1, color: Colors.black54),
                            ),
                          ),
                          child: Text("Queja sobre el conductor", style: TextStyle(fontFamily: "Monserrat"),),
                        ),
                      ),
                        Image.asset(
                          "assets/images/chica_asistencia_tecnica.png",
                          height: 120,
                        ),
                          Container(height:60.0),
                    ],
                  )
                )),
            Positioned(
                bottom: 10,
                left: 0.0,
                child: bottomNavBar(context)),
            Positioned(
                top: 0,
                left: 0.0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10.0),
                    color: Colors.black,
                    child:
                    Center(
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Quieres Cancelar el Viaje?", style: TextStyle(color: Colors.white, fontFamily: "Monserrat", fontSize: 18, fontWeight: FontWeight.bold,),),
                          ],
                        )
                    ))),
          ],
        )
    ) ;

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
            Navigator.pop(
                context,);
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