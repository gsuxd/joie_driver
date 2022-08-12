import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joiedriver/metodos_pago/components/nuevo_metodo.dart';
import 'package:joiedriver/pedidos.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:joiedriver/singletons/user_data.dart';
import 'asistencia_tecnica.dart';
import 'colors.dart';
import 'main.dart';

class PerfilUsuario extends StatefulWidget {
  const PerfilUsuario({Key? key}) : super(key: key);

  @override
  createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  Color color_icon_inicio = blue;
  Color color_icon_historial = blue;
  Color color_icon_perfil = blue_dark;
  Color color_icon_ingresos = blue;
  String state = "Tu Perfil";
  bool isSwitched = false;
  String ciudadText = "Bucaramanga";
  bool correo = false;
  bool ciudad = false;
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
            .child("ProfilePhoto.jpg")
            .putFile(image);
        _newImage = await newImage.ref.getDownloadURL();
        setState(() {});
        if (_newImage != null) {
          GetIt.I.get<UserData>().profilePicture = _newImage!;
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: blue,
          leading: Container(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 40,
                )),
          ),
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              state,
              style: const TextStyle(
                  fontFamily: "Monserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
          ]),
          actions: [
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                "assets/images/share.svg",
                height: 40,
                color: Colors.white,
              ),
            ),
            Container(
              width: 10.0,
            ),
          ],
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
                      onTap: () {
                        if (_isLoading) {
                          return;
                        }
                        _changeImage();
                      },
                      child: Stack(children: [
                        CircleAvatar(
                          backgroundImage: !_isLoading
                              ? NetworkImage(
                                  GetIt.I.get<UserData>().profilePicture)
                              : null,
                          radius: 50,
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : null,
                        ),
                        Positioned(
                          bottom: -5,
                          right: -10,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: blue,
                              shape: const CircleBorder(),
                            ),
                            child: SvgPicture.asset(
                              "assets/images/foto_de_perfil.svg",
                              height: 25.0,
                              color: Colors.white,
                            ),
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
                    Image.asset(
                      "assets/images/estrella5.png",
                      height: 20,
                    )
                  ],
                ),
                Container(
                  height: 20.0,
                ),
                item(GetIt.I.get<UserData>().name,
                    "assets/images/nombre_y_apellido.svg"),
                Container(
                  height: 20.0,
                ),
                item(GetIt.I.get<UserData>().lastName,
                    "assets/images/nombre_y_apellido.svg"),
                Container(
                  height: 20.0,
                ),
                item(GetIt.I.get<UserData>().birthDate.substring(0, 10),
                    "assets/images/edad.svg"),
                Container(
                  height: 20.0,
                ),
                itemCiudad(ciudadText, "assets/images/ciudad.svg"),
                Container(
                  height: 20.0,
                ),
                item(
                    GetIt.I.get<UserData>().genero, "assets/images/genero.svg"),
                Container(
                  height: 20.0,
                ),
                itemCorreo(
                    GetIt.I.get<UserData>().email, "assets/images/correo.svg"),
                Container(
                  height: 20.0,
                ),
                if (GetIt.I.get<UserData>().type != "usersPasajeros")
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 14),
                        child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const NuevoMetodo()),
                              );
                            },
                            icon: const Icon(Icons.monetization_on_outlined),
                            label: const Text("Metodos de pago")),
                      ),
                    ],
                  )
              ],
            ),
            Positioned(bottom: 10, left: 0.0, child: bottomNavBar(context))
          ],
        ));
  }

  GestureDetector itemCiudad(String title, String icon) {
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
            visible: !ciudad,
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    ciudad = !ciudad;
                  });
                },
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontFamily: "Monserrat",
                      fontSize: 16.0),
                )),
          ),
          Visibility(
            visible: ciudad,
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
                style: const TextStyle(
                    color: Colors.black45,
                    fontFamily: "Monserrat",
                    fontSize: 12),
                decoration: const InputDecoration(
                  hintText: "Ciudad",
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

  GestureDetector itemCorreo(String title, String icon) {
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
            visible: !correo,
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    correo = !correo;
                  });
                },
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontFamily: "Monserrat",
                      fontSize: 16.0),
                )),
          ),
          Visibility(
            visible: correo,
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
                style: const TextStyle(
                    color: Colors.black45,
                    fontFamily: "Monserrat",
                    fontSize: 12),
                decoration: const InputDecoration(
                  hintText: "Correo",
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

  GestureDetector item(String title, String icon) {
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
          Text(
            title,
            style: const TextStyle(
                color: Colors.black54, fontFamily: "Monserrat", fontSize: 16.0),
          )
        ],
      ),
    );
  }

  SizedBox bottomNavBar(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const MyApp()));
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding:
                  const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
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
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Pedidos()));
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding:
                  const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              primary: color_icon_historial,
              shape: const CircleBorder(),
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
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AsistenciaTecnicaUsuario()));
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding:
                  const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              primary: color_icon_ingresos,
              shape: const CircleBorder(),
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
          ElevatedButton(
            onPressed: () {
              setState(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PerfilUsuario()));
              });
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding:
                  const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
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
}
