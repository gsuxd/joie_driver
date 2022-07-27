import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joiedriver/pedidos.dart';
import 'package:joiedriver/profile.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:joiedriver/singletons/carro_data.dart';
import 'package:joiedriver/singletons/user_data.dart';
import 'colors.dart';
import 'estatics.dart';

class AutomovilChofer extends StatefulWidget {
  @override
  createState() => _PerfilUsuarioState();
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

  late CarroData carData;

  Future _getImage() async {
    ImagePicker imegaTemp = ImagePicker();
    var tempImage = await imegaTemp.pickImage(source: ImageSource.camera);
    return File(tempImage!.path);
  }

  String? _newImage;

  void _changeImage() async {
    setState(() {
      _isLoading = true;
    });
    final image = await _getImage();
    if (image != null) {
      try {
        final newImage = await FirebaseStorage.instance
            .ref()
            .child(GetIt.I.get<UserData>().email)
            .child("Vehicle.jpg")
            .putFile(image);
        _newImage = await newImage.ref.getDownloadURL();
        setState(() {});
        if (_newImage != null) {
          GetIt.I.get<UserData>().carroData!.picture = _newImage!;
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error al cargar la imagen"),
        ));
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    carData = GetIt.I.get<UserData>().carroData!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: blue,
          leading: GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              "assets/images/perfil_principal.svg",
              width: 24,
              color: Colors.white,
            ),
          ),
          title: Center(
            child: Text(
              titleAppBar,
              style: TextStyle(
                  fontFamily: "Monserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
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
                    Stack(children: [
                      Image.network(
                        carData.picture,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 5,
                        right: 10,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_isLoading) {
                              return;
                            }
                            _changeImage();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: blue,
                            shape: const CircleBorder(),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : SvgPicture.asset(
                                  "assets/images/foto_de_perfil.svg",
                                  height: 25.0,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ])
                  ],
                ),
                Container(
                  height: 30.0,
                ),
                itemMarca(carData.brand, "assets/images/modelo.svg"),
                Container(
                  height: 20.0,
                ),
                itemAnio(carData.year, "assets/images/edad.svg"),
                Container(
                  height: 20.0,
                ),
                itemPlaca(carData.plate, "assets/images/placa.svg"),
                Container(
                  height: 20.0,
                ),
                itemColor(carData.color, "assets/images/color.svg"),
                Container(
                  height: 20.0,
                ),
                itemCapacidad(carData.capacity, "assets/images/capacidad.svg"),
                Container(
                  height: 70.0,
                ),
              ],
            ),
            Positioned(bottom: 10, left: 0.0, child: bottomNavBar(context))
          ],
        ));
  }

  GestureDetector itemMarca(String title, String icon) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Container(
            width: 20.0,
          ),
          SvgPicture.asset(
            icon,
            color: Colors.black54,
            height: 24,
          ),
          Container(
            width: 10.0,
          ),
          Visibility(
            visible: !marca,
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    marca = !marca;
                  });
                },
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.black54,
                      fontFamily: "Monserrat",
                      fontSize: 16.0),
                )),
          ),
          Visibility(
            visible: marca,
            child: SizedBox(
              width: 150,
              height: 30.0,
              child: TextField(
                cursorHeight: 12.0,
                onTap: () {
                  setState(() {});
                },
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  setState(() {});
                },
                style: TextStyle(
                    color: Colors.black45,
                    fontFamily: "Monserrat",
                    fontSize: 12),
                decoration: InputDecoration(
                  hintText: "Modelo",
                  labelText: '',
                  labelStyle: TextStyle(fontFamily: "Monserrat", fontSize: 12),
                  //border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(15.0)), borderSide: BorderSide(color: Colors.white, width: 2),),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector itemAnio(String title, String icon) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Container(
            width: 20.0,
          ),
          SvgPicture.asset(
            icon,
            color: Colors.black54,
            height: 24,
          ),
          Container(
            width: 10.0,
          ),
          Visibility(
            visible: !anio,
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    anio = !anio;
                  });
                },
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.black54,
                      fontFamily: "Monserrat",
                      fontSize: 16.0),
                )),
          ),
          Visibility(
            visible: anio,
            child: SizedBox(
              width: 150,
              height: 30.0,
              child: TextField(
                cursorHeight: 12.0,
                onTap: () {
                  setState(() {});
                },
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  setState(() {});
                },
                style: TextStyle(
                    color: Colors.black45,
                    fontFamily: "Monserrat",
                    fontSize: 12),
                decoration: InputDecoration(
                  hintText: "Anio",
                  labelText: '',
                  labelStyle: TextStyle(fontFamily: "Monserrat", fontSize: 12),
                  //border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(15.0)), borderSide: BorderSide(color: Colors.white, width: 2),),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector itemPlaca(String title, String icon) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Container(
            width: 20.0,
          ),
          SvgPicture.asset(
            icon,
            color: Colors.black54,
            height: 24,
          ),
          Container(
            width: 10.0,
          ),
          Visibility(
            visible: !placa,
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    placa = !placa;
                  });
                },
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.black54,
                      fontFamily: "Monserrat",
                      fontSize: 16.0),
                )),
          ),
          Visibility(
            visible: placa,
            child: SizedBox(
              width: 180,
              height: 30.0,
              child: TextField(
                cursorHeight: 12.0,
                onTap: () {
                  setState(() {});
                },
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  setState(() {});
                },
                style: TextStyle(
                    color: Colors.black45,
                    fontFamily: "Monserrat",
                    fontSize: 12),
                decoration: InputDecoration(
                  hintText: "Placa",
                  labelText: '',
                  labelStyle: TextStyle(fontFamily: "Monserrat", fontSize: 12),
                  //border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(15.0)), borderSide: BorderSide(color: Colors.white, width: 2),),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector itemColor(String title, String icon) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Container(
            width: 20.0,
          ),
          SvgPicture.asset(
            icon,
            height: 24,
          ),
          Container(
            width: 10.0,
          ),
          Visibility(
            visible: !color,
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    color = !color;
                  });
                },
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.black54,
                      fontFamily: "Monserrat",
                      fontSize: 16.0),
                )),
          ),
          Visibility(
            visible: color,
            child: SizedBox(
              width: 150,
              height: 30.0,
              child: TextField(
                cursorHeight: 12.0,
                onTap: () {
                  setState(() {});
                },
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  setState(() {});
                },
                style: TextStyle(
                    color: Colors.black45,
                    fontFamily: "Monserrat",
                    fontSize: 12),
                decoration: InputDecoration(
                  hintText: "Color",
                  labelText: '',
                  labelStyle: TextStyle(fontFamily: "Monserrat", fontSize: 12),
                  //border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(15.0)), borderSide: BorderSide(color: Colors.white, width: 2),),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector itemCapacidad(String title, String icon) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Container(
            width: 20.0,
          ),
          SvgPicture.asset(
            icon,
            color: Colors.black54,
            height: 24,
          ),
          Container(
            width: 10.0,
          ),
          Visibility(
            visible: !capacidad,
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    capacidad = !capacidad;
                  });
                },
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.black54,
                      fontFamily: "Monserrat",
                      fontSize: 16.0),
                )),
          ),
          Visibility(
            visible: capacidad,
            child: SizedBox(
              width: 150,
              height: 30.0,
              child: TextField(
                cursorHeight: 12.0,
                onTap: () {
                  setState(() {});
                },
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  setState(() {});
                },
                style: TextStyle(
                    color: Colors.black45,
                    fontFamily: "Monserrat",
                    fontSize: 12),
                decoration: InputDecoration(
                  hintText: "Capacidad",
                  labelText: '',
                  labelStyle: TextStyle(fontFamily: "Monserrat", fontSize: 12),
                  //border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(15.0)), borderSide: BorderSide(color: Colors.white, width: 2),),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                ),
              ),
            ),
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
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding:
                  EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
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
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Pedidos()));
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding:
                  EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
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
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Statics()));
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding:
                  EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
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
          ElevatedButton(
            onPressed: () {
              setState(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              });
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding:
                  EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
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
    return Switch(
      value: isSwitched,
      onChanged: (value) {
        setState(() {
          isSwitched = value;
          if (state == "Desconectado") {
            state = "Conectado";
          } else {
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
