import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:joiedriver/singletons/carro_data.dart';

class UserData {
  String profilePicture;
  final String name;
  final String lastName;
  final String referralsCode;
  final String birthDate;
  final String email;
  final String genero;
  final String type;
  final CarroData? carroData;
  UserData(
      {required this.type,
      required this.email,
      required this.genero,
      required this.profilePicture,
      required this.name,
      required this.birthDate,
      required this.referralsCode,
      required this.lastName,
      this.carroData});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
      profilePicture: json["profilePicture"],
      name: json["name"],
      lastName: json["lastName"],
      referralsCode: json["code"],
      birthDate: json["datebirth"],
      email: json["email"],
      genero: json["gender"],
      type: json["type"]);

  Map<String, dynamic> toJson() => {
        "profilePicture": profilePicture,
        "name": name,
        "lastName": lastName,
        "code": referralsCode,
        "datebirth": birthDate,
        "email": email,
        "gender": genero,
        "type": type
      };
}

Future<void> registerSingleton() async {
  Map<String, dynamic>? user;
  Map<String, dynamic>? car;
  String? userType;
  await FirebaseFirestore.instance
      .doc("users/${FirebaseAuth.instance.currentUser!.email}")
      .get()
      .then((value) async {
    if (value.exists) {
      user = value.data()!;
      userType = "users";
      car = user!["vehicle"]["default"];
    } else {
      await FirebaseFirestore.instance
          .doc("usersPasajeros/${FirebaseAuth.instance.currentUser!.email}")
          .get()
          .then((value) async {
        if (value.exists) {
          user = value.data()!;
          userType = "usersPasajeros";
        } else {
          await FirebaseFirestore.instance
              .doc(
                  "usersEmprendedor/${FirebaseAuth.instance.currentUser!.email}")
              .get()
              .then((value) async {
            if (value.exists) {
              user = value.data()!;
              userType = "usersEmprendedor";
            }
          });
        }
      });
    }
    if (user != null) {
      if (car != null) {
        GetIt.I.registerSingleton(
          UserData(
              lastName: user!['lastname'],
              name: user!['name'],
              birthDate: user!['datebirth'],
              referralsCode: user!['code'],
              email: FirebaseAuth.instance.currentUser!.email!,
              genero: user!['gender'],
              type: userType!,
              profilePicture: await FirebaseStorage.instance
                  .ref()
                  .child(
                      "${FirebaseAuth.instance.currentUser!.email!}/ProfilePhoto.jpg")
                  .getDownloadURL(),
              carroData: CarroData(
                brand: car!['brand'],
                year: car!['year'].toString(),
                plate: car!['plate'],
                color: car!['color'],
                capacity: car!['capacity'].toString(),
                picture: await FirebaseStorage.instance
                    .ref()
                    .child(FirebaseAuth.instance.currentUser!.email!)
                    .child('/Vehicle.jpg')
                    .getDownloadURL(),
              )),
        );
      } else {
        GetIt.I.registerSingleton(
          UserData(
            lastName: user!['lastname'],
            name: user!['name'],
            birthDate: user!['datebirth'],
            referralsCode: user!['code'],
            email: FirebaseAuth.instance.currentUser!.email!,
            genero: user!['gender'],
            type: userType!,
            profilePicture: await FirebaseStorage.instance
                .ref()
                .child(
                    "${FirebaseAuth.instance.currentUser!.email!}/ProfilePhoto.jpg")
                .getDownloadURL(),
          ),
        );
      }
    }
  });
}
