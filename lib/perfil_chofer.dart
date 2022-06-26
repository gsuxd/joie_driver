import 'package:joiedriver/pedidos.dart';
import 'package:joiedriver/profile.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'automovil_chofer.dart';
import 'colors.dart';
import 'estatics.dart';

class PerfilChofer extends StatefulWidget {
  @override
  createState() =>  _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilChofer> {
  Color color_icon_inicio = blue;
  Color color_icon_historial = blue;
  Color color_icon_perfil = blue_dark;
  Color color_icon_ingresos = blue;
  String state = "Desconectado";
  String titleAppBar = "Tu Perfil";
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
          GestureDetector(
            onTap: (){},
            child: SvgPicture.asset(
              "assets/images/perfil_principal.svg",
              width: 24,
              color: Colors.white,
            ),
          ),
          title: Center(
            child: Text(titleAppBar, style: TextStyle(fontFamily: "Monserrat", fontWeight: FontWeight.bold, fontSize: 20.0), textAlign: TextAlign.center,),
          ),
          actions: [ConectSwitch(context)],

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
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: (){
                    print("vaya");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AutomovilChofer()));
                  },
                  child:
                  item("Mi Automovil", "assets/images/perfil_de_auto.svg"),),
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


  Row item(String title, String icon) {
    return Row(
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

}