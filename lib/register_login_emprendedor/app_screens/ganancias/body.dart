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
      if (_scrollController.position.pixels >=
          _scrollController.position.pixels * .95) {
        if (endDoc != null) {
          getDataGanancasList(endDoc);
        }
      }
    });
  }

  final List<ItemGanancia> ganaciasList = [];
  String server = "usersEmprendedor";
  //String server = "usersEmprendedorDev";
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
        .collection('$server/' + email + "/comisiones")
        //.where('date', isGreaterThan: mesAcutal)
        .orderBy('date', descending: true)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        endDoc = doc;
        ganaciasList.add(ItemGanancia(
            nameReferer: doc['name_referer'],
            codeReferer: doc['code_referer'],
            date: doc['date'],
            mount: double.parse(doc['mount'].toStringAsFixed(2)),
            description: doc['description']));
      }
    });
  }

  Future getDataGanancasList(QueryDocumentSnapshot? start) async {
    if (start != null) {
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
          .collection('$server/' + email + "/comisiones")
          //.where('date', isGreaterThan: mesAcutal)
          .orderBy('date', descending: true)
          .startAfterDocument(start)
          .limit(10)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          count = count + 1;
          ganaciasList.add(ItemGanancia(
              nameReferer: doc['name_referer'],
              codeReferer: doc['code_referer'],
              date: doc['date'],
              mount: double.parse(doc['mount'].toStringAsFixed(2)),
              description: doc['description']));
          tempSnap = doc;
        }
        if (count >= 10) {
          endDoc = tempSnap;
        } else {
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
        .collection('$server/' + email + "/comisiones")
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

  //Produccion
  CollectionReference users =
      FirebaseFirestore.instance.collection('usersEmprendedor');

  //Desarrollo
  // CollectionReference users =
  // FirebaseFirestore.instance.collection('usersEmprendedorDev');

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return FutureBuilder<DocumentSnapshot>(
        future: nameFuture(),
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

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10.0),
                    child: Column(
                      children: [
                        Text(
                          "Saldo Personal",
                          style: textStyleGreyName(),
                        ),
                        Text(
                          data['nameComplete'].toString().toUpperCase(),
                          style: textStyleGreyName(),
                        )
                      ],
                    ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ganancias(),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  color: blue_light,
                  height: 20.0,
                ),
                Expanded(
                    child: ListView.separated(
                      //padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20.0),
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          return itemGanancia(ganaciasList[index], context);
                        },
                        separatorBuilder: (context, index) => Container(
                              color: blue_light,
                              height: 10.0,
                            ),
                        itemCount: ganaciasList.length)),
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



  Column itemGanancia(ItemGanancia ganancia, BuildContext context){
    Timestamp fecha = ganancia.date;
    var date = DateTime.fromMicrosecondsSinceEpoch(fecha.microsecondsSinceEpoch);
    return
      Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 10.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .15 - 10,
                child: Column(
                  children: [
                    Text("${date.day} ${date.month}", style: textStyleBlueItemGanancia(),),
                    Text("${date.year}", style: textStyleBlueItemGanancia(),)
                  ],
                ),
              ),

              const SizedBox(
                width: 5.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .50 - 10.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ganancia.description, style: textStyleGreyName(),),
                    Text(ganancia.nameReferer, style: textStyleGreyName(),),
                  ],
                ),
              ),

              const SizedBox(
                width: 10.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .35 - 10.0,
                child: Text("S/. " + double.parse(ganancia.mount.toStringAsFixed(2)).toString(), style: textStyleBlueItemGanancia(),),
              ),

              const SizedBox(
                width: 5.0,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      )
      ;
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
