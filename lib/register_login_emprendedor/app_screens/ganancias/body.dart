import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:joiedriver/register_login_emprendedor/app_screens/ganancias/item_ganancia.dart';
import '../../../colors.dart';

class BodyGanancias extends ConsumerStatefulWidget {
  const BodyGanancias({Key? key}) : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends ConsumerState<BodyGanancias> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.pixels *.95){
        if(endDoc != null){
          print("entro");
          getDataGanancasList(endDoc);
        }
      }
    });
  }
  final List<ItemGanancia> ganaciasList = [];



  Future getDataGanancasListInit() async {
    DateTime mesAcutal = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      1,
      0,
      0,
      0,
    );
    await FirebaseFirestore.instance
        .collection('usersEmprendedor/' + email + "/comisiones")
        .where('date', isGreaterThan: mesAcutal)
        .orderBy('date', descending: true)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        endDoc = doc;
        ganaciasList.add(ItemGanancia(nameReferer: doc['name_referer'], codeReferer: doc['code_referer'], date: doc['date'], mount: double.parse(doc['mount'].toStringAsFixed(2)), description: doc['description']));
      }
    });
  }

  Future getDataGanancasList(QueryDocumentSnapshot? start) async {
    if(start != null){
      int count = 0;
      late QueryDocumentSnapshot tempSnap;
      DateTime mesAcutal = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        1,
        0,
        0,
        0,
      );
      await FirebaseFirestore.instance
          .collection('usersEmprendedor/' + email + "/comisiones")
          .where('date', isGreaterThan: mesAcutal)
          .orderBy('date', descending: true)
          .startAfterDocument(start!)
          .limit(10)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          count = count + 1;
          ganaciasList.add(ItemGanancia(nameReferer: doc['name_referer'], codeReferer: doc['code_referer'], date: doc['date'], mount: double.parse(doc['mount'].toStringAsFixed(2)), description: doc['description']));
          tempSnap = doc;
        }
        if(count >= 10){
          endDoc = tempSnap;
        }else{
          endDoc = null;
        }

      });
    }
  }


  Future getDataGanancas() async {
    sum = 0;
    DateTime mesAcutal = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      1,
      0,
      0,
      0,
    );
    await FirebaseFirestore.instance
        .collection('usersEmprendedor/' + email + "/comisiones")
        .where('date', isGreaterThan: mesAcutal)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        sum = sum + double.parse(doc['mount'].toStringAsFixed(2));
      }
    });
  }
  late ScrollController _scrollController;
  bool isLoading = false;
  bool hashMore = true;

  QueryDocumentSnapshot? endDoc;
  String email = "None";
  double sum = 0;
  EncryptedSharedPreferences encryptedSharedPreferences =
      EncryptedSharedPreferences();
  CollectionReference users =
      FirebaseFirestore.instance.collection('usersEmprendedor');

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return FutureBuilder<DocumentSnapshot>(
            future: nameFuture(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
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

                return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Saldo Personal",
                          style: textStyleGreyName(),
                        ),
                        Text(
                          data['nameComplete'].toString().toUpperCase(),
                          style: textStyleGreyName(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ganancias(),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Expanded(
                            child: ListView.separated(
                              controller: _scrollController,
                                itemBuilder: (context, index) {
                                  return Text(ganaciasList[index].nameReferer, style: const TextStyle(color: Colors.black),);
                                },
                                separatorBuilder: (context, index) =>  Container(
                                  color: blue_light,
                                  height: 50.0,
                                ),
                                itemCount: ganaciasList.length
                            )
                        ),
                      ],
                );
              }
              return const LinearProgressIndicator();
            },
          );
    });
  }

  Future<DocumentSnapshot> nameFuture() async {
    email = await encryptedSharedPreferences.getString('email');
    await getDataGanancas();
    await getDataGanancasListInit();
    await getDataGanancasList(endDoc);
    return users.doc(email).get();
  }

  Row ganancias() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/icons/bolsa.svg",
          height: 60,
        ),
        const SizedBox(
          width: 10.0,
        ),
        Column(
          children: [
            Text(
              "Tus Ganancias",
              style: textStyleBlue(),
            ),
            Text(
              "S/. ${double.parse(sum.toStringAsFixed(2))}",
              style: textStyleGreen(),
            )
          ],
        )
      ],
    );
  }
}
