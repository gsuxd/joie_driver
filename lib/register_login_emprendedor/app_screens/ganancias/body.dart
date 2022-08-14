import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../colors.dart';

class BodyGanancias extends ConsumerStatefulWidget {
  const BodyGanancias({Key? key}) : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends ConsumerState<BodyGanancias> {
  Future getDataGanancas() async {
    sum = 0;
    email = await encryptedSharedPreferences.getString('email');
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
        sum = sum + doc["mount"];
      }
    });
  }

  String email = "None";
  double sum = 0;
  EncryptedSharedPreferences encryptedSharedPreferences =
      EncryptedSharedPreferences();
  CollectionReference users =
      FirebaseFirestore.instance.collection('usersEmprendedor');

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<DocumentSnapshot>(
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

                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 10),
                  child: Column(
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
                      ]),
                );
              }
              return const LinearProgressIndicator();
            },
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Divider(
            color: blue_light,
            thickness: 30.0,
          ),
        ],
      );
    });
  }

  Future<DocumentSnapshot> nameFuture() async {
    email = await encryptedSharedPreferences.getString('email');
    await getDataGanancas();
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
              "S/. $sum",
              style: textStyleGreen(),
            )
          ],
        )
      ],
    );
  }
}
