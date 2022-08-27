import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../colors.dart';
import '../../conts.dart';
import '../appbar.dart';

class BancoEmprendedor extends StatefulWidget {
  @override
  createState() => _BancoUsuarioState();
}

class _BancoUsuarioState extends State<BancoEmprendedor> {
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

  Future<void> updateUser() {
    return users
        .doc(email)
        .update({
          'number_bank': _controllerTextNumberCta.text,
          'bank': _controllerTextBank,
          'type_bank' : _controllerTextBankType,
        })
        .then((value) => Fluttertoast.showToast(
            msg: "Actualización Exitosa!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0))
        .catchError((error) => Fluttertoast.showToast(
            msg: "$error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0));
  }

  String init = "0";
  String initType = "0";
  final TextEditingController _controllerTextNumberCta =
      TextEditingController();
  late String _controllerTextBank = "";
  late String _controllerTextBankType = "";
  String email = "None";
  EncryptedSharedPreferences encryptedSharedPreferences =
      EncryptedSharedPreferences();
  final storageRef = FirebaseStorage.instance.ref();
  Reference? imagesRef;
  final profilePhoto = "ProfilePhoto.jpg";
  String urlImage = "";

  //Produccion
  //CollectionReference users =
  //    FirebaseFirestore.instance.collection('usersEmprendedor');

  //Desarrollo
  CollectionReference users =
      FirebaseFirestore.instance.collection('usersEmprendedorDev');

  List<String> listBanks = [
    "Bancolombia",
    "BBVA",
    "Banco de Bogotá",
    "ColPatria",
    "Davivienda",
    "Banco AV Villas",
    "Bancamía",
    "Banco Agrario",
    "Banco Caja Social",
    'Banco Cooperativo Coopcentral',
    'Banco Credifinaciera',
    'Banco de Occidente',
    'Banco Falabella',
    'Banco Finandina',
    'Banco Itaú',
    'Banco Pichincha',
    'Banco Popular de Colombia',
    'BancoW',
    'Bancoomeva',
    'Bancoldex'
  ];


  List<String> listBanksType = [
    "Ahorro",
    "Corriente",
  ];

  List<String> listBanksImage = [
    bancolombia,
    bbva,
    bogotaBank,
    colpatria,
    davivienda,
    avvillas,
    bancamia,
    bancoAgrario,
    bancoCajaSocial,
    bancoCoopCentral,
    credifinanciera,
    bancodeOccidente,
    falabella,
    finandia,
    itau,
    pichincha,
    bpc,
    bancoW,
    bancoOmeva,
    bancoldex
  ];

  List<String> listBanksTypeImage = [
    tipodeCuenta,
    tipodeCuenta,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarEmprendedor(
            accion: [], leading: back(context), title: 'Datos Bancarios'),
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
              _controllerTextNumberCta.text = data['number_bank'].toString();
              _controllerTextBank = data['bank'].toString();
              _controllerTextBankType = data['type_bank'].toString();
              for (int i = 0; i < 20; i++) {
                if (_controllerTextBank == listBanks[i]) {
                  init = i.toString();
                  break;
                }
              }

              for (int i = 0; i < 3; i++) {
                if (_controllerTextBankType == listBanksType[i]) {
                  initType = i.toString();
                  break;
                }
              }
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
                        child: FutureBuilder<String?>(
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
                              //lo que se muestra cuando la carga se completa
                              return Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(85.0),
                                        child: Image.network(
                                          snapshot.data!,
                                          height: 170.0,
                                          width: 170.0,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                  Text(
                                    data['name'].toString().toUpperCase(),
                                    style: textStyleGreyName(),
                                  ),
                                  Text(
                                    data['lastname'].toString().toUpperCase(),
                                    style: textStyleGreyName(),
                                  ),
                                  Text(
                                    "Ci: ${data['number_ci'].toString().toUpperCase()}",
                                    style: textStyleGreyName(),
                                  ),
                                ],
                              );
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
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  selectBank(),
                  selectBankType(),
                  bankFormField(
                      _controllerTextNumberCta,
                      "Ingresa tu Número de Cuenta",
                      "Número de cuenta",
                      "assets/icons/banco.svg"),
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

  Padding bankFormField(TextEditingController controller, String? hint,
      String? label, String icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        maxLength: 20,
        style: textStyleGreyNameCity(),
        textInputAction: TextInputAction.done,
        controller: controller,
        cursorColor: Colors.grey,
        onEditingComplete: () {
          updateUser();
        },
        onChanged: (value) {},
        keyboardType: const TextInputType.numberWithOptions(signed: true),
        autocorrect: true,
        decoration: InputDecoration(
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

  selectBank() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        isExpanded: true,
        value: init,
        elevation: 16,
        style: const TextStyle(color: Colors.grey),
        onChanged: (String? newValue) {
          setState(() {
            init = newValue!;
            _controllerTextBank = listBanks[int.parse(newValue)];
            updateUser();
          });
        },
        items: <String>[
          '0',
          '1',
          '2',
          '3',
          '4',
          '5',
          '6',
          '7',
          '8',
          '9',
          '10',
          '11',
          '12',
          '13',
          '14',
          '15',
          '16',
          '17',
          '18',
          '19',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Text(listBanks[int.parse(value)], style: textStyleGreyName(),),
                    SvgPicture.asset(
                      listBanksImage[int.parse(value)],
                      height: 30,
                    ),
                  ]),
            ),
          );
        }).toList(),
      ),
    );
  }

  selectBankType() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        isExpanded: true,
        value: initType,
        elevation: 16,
        style: const TextStyle(color: Colors.grey),
        onChanged: (String? newValue) {
          setState(() {
            initType = newValue!;
            _controllerTextBankType = listBanksType[int.parse(newValue)];
            updateUser();
          });
        },
        items: <String>[
          '0',
          '1',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      listBanksTypeImage[int.parse(value)],
                      height: 30,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(listBanksType[int.parse(value)], style: textStyleGreyName(),),
                  ]),
            ),
          );
        }).toList(),
      ),
    );
  }
}
