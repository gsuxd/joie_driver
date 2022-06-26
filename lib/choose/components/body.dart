import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../register_login_chofer/splash/splash_screen.dart';
import '../../register_login_user/splash/splash_screen.dart';

class Body extends StatefulWidget {

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      //Hacemos un ListView en caso de que la pantalla tenga poco alto (como por ejemplo cuando el cel esta en horizontal)
      body: ListView(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Logo
                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: 100,
                  height: 100,
                  child: SvgPicture.asset("assets/icons/logo.svg"),
                ),
                //Bienvenido
                Container(
                  margin: EdgeInsets.only(top: 32),
                  child: Text(
                    "Bienvenido",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat Black",
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //Usuario o conductor (texto)
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 42),
                  child: Text(
                    "¿Eres usuario o conductor?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat Black",
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //Conductor: Aca llamamos a la función selectType() que tendrá como parámetros: la funcion al presionar, la URL del archivo SVG, y el texto que contendra
                selectType(() => { Navigator.push( context, MaterialPageRoute(builder: (context) => SplashScreen()))}, "assets/icons/conductor.svg", "Conductor"),
                //Usuario: Aca llamamos a la función selectType() que tendrá como parámetros: la funcion al presionar, la URL del archivo SVG, y el texto que contendra
                selectType(() => { Navigator.push( context, MaterialPageRoute(builder: (context) => SplashScreenUser()))}, "assets/icons/usuarios.svg", "Usuario"),
              ],
            ),
          ),
        ],
      ), 
    );
  }
}

//creamos la función selectType() que sera un GestureDetector tendrá como parámetros: la funcion al presionar, la URL del archivo SVG, y el texto que contendra
                
GestureDetector selectType(Function() action, String src, String text) {
  return GestureDetector(
    onTap: action, //action es la funcion que se realizara al presionar en el widget
    child: Column(
      children: [
        Container(
          width: 100,
          height: 100,
          child: SvgPicture.asset(src),//src es la URL del archivo SVG
        ),
        Container(
          margin: EdgeInsets.only(top: 25, bottom: 45),
          child: Text(
            text, //text es el texto que tendra el container
            style: TextStyle(
              fontFamily: "Montserrat black",
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ],
    ),
  );
}


