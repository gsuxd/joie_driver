import 'package:joiedriver/pedidos.dart';
import 'package:joiedriver/profile.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'colors.dart';
import 'estatics.dart';

class AutomovilChofer extends StatefulWidget {
  @override
  createState() =>  _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<AutomovilChofer> {
  Color color_icon_inicio = blue;
  Color color_icon_historial = blue;
  Color color_icon_perfil = blue_dark;
  Color color_icon_ingresos = blue;
  String state = "Desconectado";
  String titleAppBar = "Tu Perfil";
  bool isSwitched = false;
  String marcaText = "Mercedes Benz";
  String anioText = "2016";
  String placaText = "MK3SHN";
  String colorText = "Color gris";
  String capacidadText = "capacidad 5 pasajeros";
  bool anio = false;
  bool marca = false;
  bool placa = false;
  bool color = false;
  bool capacidad = false;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child:

                      Stack(
                          children:[
                            Image.network("https://carvin-info.com/wp-content/uploads/2019/05/mercedes_benz-vin-number.jpg", width: MediaQuery.of(context).size.width, height: 150.0, fit: BoxFit.cover,),
                            Positioned(
                              bottom: 5,
                              right: 10,
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
                  height: 30.0,
                ),
                itemMarca(marcaText, "assets/images/modelo.svg"),

                Container(
                  height: 20.0,
                ),
                itemAnio(anioText, "assets/images/edad.svg"),
                Container(
                  height: 20.0,
                ),
                itemPlaca(placaText, "assets/images/placa.svg"),
                Container(
                  height: 20.0,
                ),
                itemColor(colorText, "assets/images/color.svg"),
                Container(
                  height: 20.0,
                ),
                itemCapacidad(capacidadText, "assets/images/capacidad.svg"),

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

  GestureDetector itemMarca(String title, String icon) {
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
            visible: !marca,
            child:  GestureDetector(
                onTap: (){
                  setState(() {
                    marca = !marca;
                  });
                },
                child:
                Text(title, style: TextStyle(color: Colors.black54, fontFamily: "Monserrat", fontSize: 16.0),)
            ),),
          Visibility(
            visible: marca,
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
                  hintText: "Modelo",
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

  GestureDetector itemAnio(String title, String icon) {
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
            visible: !anio,
            child:  GestureDetector(
                onTap: (){
                  setState(() {
                    anio = !anio;
                  });
                },
                child:
                Text(title, style: TextStyle(color: Colors.black54, fontFamily: "Monserrat", fontSize: 16.0),)
            ),),
          Visibility(
            visible: anio,
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
                  hintText: "Anio",
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

  GestureDetector itemPlaca(String title, String icon) {
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
            visible: !placa,
            child:  GestureDetector(
                onTap: (){
                  setState(() {
                    placa = !placa;
                  });
                },
                child:
                Text(title, style: TextStyle(color: Colors.black54, fontFamily: "Monserrat", fontSize: 16.0),)
            ),),
          Visibility(
            visible: placa,
            child:                       SizedBox(
              width: 180,
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
                  hintText: "Placa",
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

  GestureDetector itemColor(String title, String icon) {
    return GestureDetector(
      onTap: (){},
      child: Row(
        children: [
          Container(
            width: 20.0,
          ),
          SvgPicture.asset(icon,
            height: 24,
          ),
          Container(
            width: 10.0,
          ),
          Visibility(
            visible: !color,
            child:  GestureDetector(
                onTap: (){
                  setState(() {
                    color = !color;
                  });
                },
                child:
                Text(title, style: TextStyle(color: Colors.black54, fontFamily: "Monserrat", fontSize: 16.0),)
            ),),
          Visibility(
            visible: color,
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
                  hintText: "Color",
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

  GestureDetector itemCapacidad(String title, String icon) {
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
            visible: !capacidad,
            child:  GestureDetector(
                onTap: (){
                  setState(() {
                    capacidad = !capacidad;
                  });
                },
                child:
                Text(title, style: TextStyle(color: Colors.black54, fontFamily: "Monserrat", fontSize: 16.0),)
            ),),
          Visibility(
            visible: capacidad,
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
                  hintText: "Capacidad",
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