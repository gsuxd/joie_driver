import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../../colors.dart';
import '../../conts.dart';
import '../appbar.dart';
import 'dart:io';

class PerfilEmprendedor extends StatefulWidget {
  @override
  createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilEmprendedor> {
  Future<DocumentSnapshot> getData() async {
    email = await encryptedSharedPreferences.getString('email');
    imagesRef = storageRef.child(email);
    return await users.doc(email).get();
  }

  Future<String?> getDataImage() async {
    email = await encryptedSharedPreferences.getString('email');
    final spaceRef = imagesRef?.child(profilePhoto);
    return await spaceRef?.getDownloadURL();
  }



  Future getImage() async {
    Widget cargaImage = const CircularProgressIndicator();
    ImagePicker imegaTemp = ImagePicker();
    var tempImage = await imegaTemp.pickImage(
        source: ImageSource.camera,
    imageQuality: 70);
    phofilePhoto = File(tempImage!.path);
    if (phofilePhoto != null) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) =>  AlertDialog(
            title: const Text('Cambiando foto de Perfil'),
            content:
                SizedBox(
                  width: 200.0,
                    height: 200.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      const Text('Subiendo Foto'),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                          child: cargaImage,
                        ),
                    ],
                  ),
                )
          )
      );
      await upload();
      cargaImage = SvgPicture.asset("assets/icons/tipodecuenta.svg", color: Colors.greenAccent,);
      setState(() {
        Navigator.pop(context);
        showDialog<String>(
            context: context,
            builder: (BuildContext context) =>  AlertDialog(
                title: const Text('Cambiando foto de Perfil'),
                content:
                SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      const Text('Subiendo Foto'),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: cargaImage,
                      ),
                    ],
                  ),
                )
            )
        );
      });
    }
  }

  Future<bool> upload() async {
    try {
      Reference img3 = FirebaseStorage.instance
          .ref()
          .child(email)
          .child('/ProfilePhoto.jpg');
      UploadTask uploadTaskProfilePhoto = img3.putFile(phofilePhoto!);
      await uploadTaskProfilePhoto.whenComplete(() {});
      phofilePhoto?.delete(recursive: true);
      return true;
    } on FirebaseAuthException catch (error) {
      return false;
    }
  }

  Future<void> updateUser() {
    return users
        .doc(email)
        .update({'city': _controllerTextCity.text, 'address': _controllerTextAddress.text})
        .then((value) => Fluttertoast.showToast(
        msg: "Actualización Exitosa!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    ))
        .catchError((error) =>Fluttertoast.showToast(
        msg: "$error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    ));
  }

  final TextEditingController _controllerTextCity = TextEditingController();
  final TextEditingController _controllerTextAddress = TextEditingController();
  File? phofilePhoto;
  String email = "None";
  EncryptedSharedPreferences encryptedSharedPreferences =
      EncryptedSharedPreferences();
  final storageRef = FirebaseStorage.instance.ref();
  Reference? imagesRef;
  final profilePhoto = "ProfilePhoto.jpg";
  String urlImage = "";

  CollectionReference users =
      FirebaseFirestore.instance.collection('usersEmprendedor');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarEmprendedor(
            accion: [], leading: back(context), title: 'Perfil'),
        body: FutureBuilder<DocumentSnapshot>(
          future: getData(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                    ),
                    child: Center(
                        child: Text("Verifica tu Conexión",
                            style: textStyleBlack())),
                  )
                ],
              );
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                    ),
                    child: Center(
                        child: Text("Error al obtener los datos",
                            style: textStyleBlack())),
                  )
                ],
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              _controllerTextCity.text = data['city'].toString();
              _controllerTextAddress.text = data['address'].toString();
              return ListView(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Stack(children: [
                          FutureBuilder<String?>(
                            future: getDataImage(),
                            builder: (BuildContext context,
                                AsyncSnapshot<String?> snapshot) {
                              if (snapshot.hasError) {
                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                        color: Colors.redAccent,
                                      ),
                                      child: Center(
                                          child: Text("Verifica tu Conexión",
                                              style: textStyleBlack())),
                                    )
                                  ],
                                );
                              }

                              if (snapshot.hasData && snapshot.data == null) {
                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                        color: Colors.redAccent,
                                      ),
                                      child: Center(
                                          child: Text(
                                              "Error al obtener los datos",
                                              style: textStyleBlack())),
                                    )
                                  ],
                                );
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                print(snapshot.data);
                                //lo que se muestra cuando la carga se completa
                                return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(85.0),
                                      child: Image.network(
                                        snapshot.data!,
                                        height: 170.0,
                                        width: 170.0,
                                        fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context, Widget child,
                                              ImageChunkEvent? loadingProgress){
                                            if(loadingProgress?.expectedTotalBytes != loadingProgress?.cumulativeBytesLoaded){
                                              return const SizedBox(
                                                height: 170,
                                                width: 170,
                                                child: Padding(
                                                  padding: EdgeInsets.all(50.0),
                                                  child: CircularProgressIndicator(
                                                    //value: (loadingProgress!.cumulativeBytesLoaded! / loadingProgress!.expectedTotalBytes!),
                                                  ),
                                                ),
                                              );}else{
                                              return child;
                                            }
                                          },
                                      ),
                                    ));
                              }
                              //lo que se muestra mientras carga
                              return const SizedBox(
                                height: 170,
                                width: 170,
                                child: Padding(
                                  padding: EdgeInsets.all(50.0),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 2,
                            right: -3,
                            child: ElevatedButton(
                              onPressed: getImage,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(10.0),
                                primary: jBase,
                                shape: const CircleBorder(),
                              ),
                              child: SvgPicture.asset(
                                "assets/images/foto_de_perfil.svg",
                                height: 30.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  item(data['name'].toString().toUpperCase(),
                      "assets/images/nombre_y_apellido.svg"),
                  const SizedBox(
                    height: 25.0,
                  ),
                  item(data['lastname'].toString().toUpperCase(),
                      "assets/images/nombre_y_apellido.svg"),
                  const SizedBox(
                    height: 25.0,
                  ),
                  item(data['datebirth'].toString().substring(0, 10),
                      "assets/images/edad.svg"),
                  const SizedBox(
                    height: 25.0,
                  ),

                  item(data['gender'].toString().toUpperCase(),
                      "assets/images/genero.svg"),
                  const SizedBox(
                    height: 25.0,
                  ),
                  item(email, "assets/images/correo.svg"),
                  cityFormField(_controllerTextCity, "Ingresa tu Ciudad", "Ciudad", "assets/icons/city.svg"),
                  cityFormField(_controllerTextAddress, "Ingresa tu Dirección", "Dirección", "assets/icons/direccion.svg"),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              );
            }
            return const LinearProgressIndicator();
          },
        ));
  }

  Row item(String title, String icon) {
    return Row(
      children: [
        const SizedBox(
          width: 20.0,
        ),
        SvgPicture.asset(
          icon,
          color: Colors.black54,
          height: 30,
        ),
        const SizedBox(
          width: 10.0,
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.black54, fontFamily: "Monserrat", fontSize: 18.0),
        )
      ],
    );
  }

  Padding cityFormField(TextEditingController controller, String? hint, String? label, String icon) {
    return
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(

        style: textStyleGreyNameCity(),
        textInputAction: TextInputAction.done,
        controller: controller,
        cursorColor: Colors.grey,
        onEditingComplete: (){
          updateUser();
        },

        onChanged: (value) {

        },
        keyboardType: TextInputType.streetAddress,
        autocorrect: true,
        decoration:  InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
              color: jBase,
              width: 0.0,
            ),
          ),
            hintStyle: textStyleGreyName(),
            hintText: hint,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: SvgPicture.asset(
                icon,
                height: 10,
              ),
            ),
            ),
      ),
      );
  }
}
