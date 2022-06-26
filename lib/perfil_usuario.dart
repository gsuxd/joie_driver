import 'package:joiedriver/pedidos.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'asistencia_tecnica.dart';
import 'colors.dart';
import 'main.dart';

class PerfilUsuario extends StatefulWidget {
  @override
  createState() =>  _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  Color color_icon_inicio = blue;
  Color color_icon_historial = blue;
  Color color_icon_perfil = blue_dark;
  Color color_icon_ingresos = blue;
  String state = "Tu Perfil";
  bool isSwitched = false;
  String correoText = "ejemplorandom@gmail.com";
  String ciudadText = "Bucaramanga";
  bool correo = false;
  bool ciudad = false;
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
                child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 40,)
            ),
          ),
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state, style: TextStyle(fontFamily: "Monserrat", fontWeight: FontWeight.bold, fontSize: 25.0), textAlign: TextAlign.center,),]
          ),
          actions: [GestureDetector(
            onTap: (){},
            child: SvgPicture.asset(
              "assets/images/share.svg",
              height: 40,
              color: Colors.white,

            ),
          ), Container(
            width: 10.0,
          ),],

        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  height: 10.0,
                ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child:

                          Stack(
                              children:[
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/images/girld2.jpg"),
                            radius: 50,
                          ),
                                Positioned(
                                  bottom: -5,
                                  right: -10,
                                  child: ElevatedButton(
                                    onPressed: (){},
                                    style: ElevatedButton.styleFrom(
                                      primary: blue,
                                      shape: CircleBorder(),
                                    ),
                                    child: SvgPicture.asset("assets/images/foto_de_perfil.svg", height: 25.0, color: Colors.white,),
                                  ),
                                ),
                              ]),
                        )

                      ],
                    ),

                
                Container(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/estrella5.png", height: 20,)
                  ],
                ),

                Container(
                  height: 20.0,
                ),
                item("Melina", "assets/images/nombre_y_apellido.svg"),
                Container(
                  height: 20.0,
                ),
                item("Sabedra", "assets/images/nombre_y_apellido.svg"),
                Container(
                  height: 20.0,
                ),
                item("14/06/1993", "assets/images/edad.svg"),
                Container(
                  height: 20.0,
                ),
                itemCiudad(ciudadText, "assets/images/ciudad.svg"),
                Container(
                  height: 20.0,
                ),
                item("Femenino", "assets/images/genero.svg"),
                Container(
                  height: 20.0,
                ),
                itemCorreo(correoText, "assets/images/correo.svg"),
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

  GestureDetector itemCiudad(String title, String icon) {
    return GestureDetector(
      onTap: (){},
      child: Row(
        children: [
          Container(
            width: 20.0,
          ),
          SvgPicture.asset(icon,
            color: Colors.black54,
            height: 24,
          ),
          Container(
            width: 10.0,
          ),
          Visibility(
              visible: !ciudad,
              child:  GestureDetector(
                onTap: (){
                  setState(() {
                    ciudad = !ciudad;
                  });
                },
                  child:
                  Text(title, style: TextStyle(color: Colors.black54, fontFamily: "Monserrat", fontSize: 16.0),)
              ),),
          Visibility(
            visible: ciudad,
            child:                       SizedBox(
              width: 150,
              height: 30.0,
              child:
              TextField(
              cursorHeight: 12.0,
              onTap: (){
                setState(() {

                });
              },
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.text,
              onChanged: (text){
                setState(() {
                });
              },
              style: TextStyle(color: Colors.black45, fontFamily: "Monserrat", fontSize:12),

              decoration: InputDecoration(
                hintText: "Ciudad",
                labelText: '',
                labelStyle: TextStyle( fontFamily: "Monserrat", fontSize: 12),
                //border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(15.0)), borderSide: BorderSide(color: Colors.white, width: 2),),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 0),
                ),
              ),

            ),),
          )
         ],
      ),
    );
  }

  GestureDetector itemCorreo(String title, String icon) {
    return GestureDetector(
      onTap: (){},
      child: Row(
        children: [
          Container(
            width: 20.0,
          ),
          SvgPicture.asset(icon,
            color: Colors.black54,
            height: 24,
          ),
          Container(
            width: 10.0,
          ),
          Visibility(
            visible: !correo,
            child:  GestureDetector(
                onTap: (){
                  setState(() {
                    correo = !correo;
                  });
                },
                child:
                Text(title, style: TextStyle(color: Colors.black54, fontFamily: "Monserrat", fontSize: 16.0),)
            ),),
          Visibility(
            visible: correo,
            child:                       SizedBox(
              width: 150,
              height: 30.0,
              child:
              TextField(
                cursorHeight: 12.0,
                onTap: (){
                  setState(() {

                  });
                },
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                onChanged: (text){
                  setState(() {
                  });
                },
                style: TextStyle(color: Colors.black45, fontFamily: "Monserrat", fontSize:12),

                decoration: InputDecoration(
                  hintText: "Correo",
                  labelText: '',
                  labelStyle: TextStyle( fontFamily: "Monserrat", fontSize: 12),
                  //border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(15.0)), borderSide: BorderSide(color: Colors.white, width: 2),),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                ),

              ),),
          )
        ],
      ),
    );
  }


  GestureDetector item(String title, String icon) {
    return GestureDetector(
        onTap: (){},
        child: Row(
          children: [
            Container(
              width: 20.0,
            ),
            SvgPicture.asset(icon,
              color: Colors.black54,
              height: 24,
            ),
            Container(
              width: 10.0,
            ),
            Text(title, style: TextStyle(color: Colors.black54, fontFamily: "Monserrat", fontSize: 16.0),)
          ],
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
                    builder: (context) => MyApp()));
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