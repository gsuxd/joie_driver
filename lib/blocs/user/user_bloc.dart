import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:joiedriver/conts.dart';
import 'package:joiedriver/home/home.dart';
import 'package:joiedriver/home_user/home.dart';
import 'package:joiedriver/singletons/carro_data.dart';
import 'package:joiedriver/singletons/user_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoading()) {
    on<LoadUserEvent>(_handleLoadUser);
    on<LoginUserEvent>(_handleLogin);
  }

  late DocumentReference<Map<String, dynamic>> userSnapshot;

  @override
  Future<void> close() async {
    if (state is UserLogged) {
      if ((state as UserLogged).user.carroData != null) {
        await userSnapshot.update({"active": false});
      }
    }
    await super.close();
  }

  void _handleLoadUser(LoadUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("user") == null) {
      emit(UserNotLogged());
      return;
    }
    final UserData user =
        UserData.fromJson(jsonDecode(prefs.getString("user")!));
    late DocumentReference<Map<String, dynamic>> userSnapshot;
    switch (user.type) {
      case 'chofer':
        userSnapshot =
            FirebaseFirestore.instance.collection("users").doc(user.email);
        break;
      case 'emprendedor':
        userSnapshot = FirebaseFirestore.instance
            .collection("usersEmprendedor")
            .doc(user.email);
        break;
      default:
        userSnapshot = FirebaseFirestore.instance
            .collection("usersPasajeros")
            .doc(user.email);
    }
    emit(UserLogged(user, userSnapshot));
  }

  void _handleLogin(LoginUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      await FirebaseFirestore.instance
          .doc("users/${user.user!.email}")
          .get()
          .then(
        (value) async {
          if (value.exists) {
            final u = UserData(
              lastName: value['lastname'],
              name: value['name'],
              birthDate: value['datebirth'],
              referralsCode: value['code'],
              email: FirebaseAuth.instance.currentUser!.email!,
              genero: value['gender'],
              type: "chofer",
              profilePicture: await FirebaseStorage.instance
                  .ref()
                  .child(
                      "${FirebaseAuth.instance.currentUser!.email!}/ProfilePhoto.jpg")
                  .getDownloadURL(),
              carroData: CarroData(
                brand: value["vehicle"]["default"]['brand'],
                type: value["vehicle"]["default"]['type'] ??
                    VehicleType.particular,
                year: value["vehicle"]["default"]['year'].toString(),
                plate: value["vehicle"]["default"]['plate'],
                color: value["vehicle"]["default"]['color'],
                capacity: value["vehicle"]["default"]['capacity'].toString(),
                picture: await FirebaseStorage.instance
                    .ref()
                    .child(FirebaseAuth.instance.currentUser!.email!)
                    .child('/Vehicle.jpg')
                    .getDownloadURL(),
              ),
            );
            value.reference.update({"active": true});
            userSnapshot = value.reference;
            emit(UserLogged(u, value.reference));
            prefs.setString("user", jsonEncode(u.toJson()));
            Navigator.of(event.context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (route) => false);
            return;
          } else {
            await FirebaseFirestore.instance
                .doc("usersPasajeros/${user.user!.email}")
                .get()
                .then(
              (value) async {
                if (value.exists) {
                  final u = UserData(
                    lastName: value['lastname'],
                    name: value['name'],
                    birthDate: value['datebirth'],
                    referralsCode: value['code'],
                    email: FirebaseAuth.instance.currentUser!.email!,
                    genero: value['gender'],
                    type: "pasajero",
                    profilePicture: await FirebaseStorage.instance
                        .ref()
                        .child(
                            "${FirebaseAuth.instance.currentUser!.email!}/ProfilePhoto.jpg")
                        .getDownloadURL(),
                  );
                  emit(
                    UserLogged(u, value.reference),
                  );
                  prefs.setString(
                    "user",
                    jsonEncode(
                      u.toJson(),
                    ),
                  );
                  userSnapshot = value.reference;
                  Navigator.of(event.context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const HomeScreenUser()));
                  return;
                } else {
                  await FirebaseFirestore.instance
                      .doc("usersEmprendedor/${user.user!.email}")
                      .get()
                      .then(
                    (value) async {
                      if (value.exists) {
                        final u = UserData(
                          lastName: value['lastname'],
                          name: value['name'],
                          birthDate: value['datebirth'],
                          referralsCode: value['code'],
                          email: FirebaseAuth.instance.currentUser!.email!,
                          genero: value['gender'],
                          type: "emprendedor",
                          profilePicture: await FirebaseStorage.instance
                              .ref()
                              .child(
                                  "${FirebaseAuth.instance.currentUser!.email!}/ProfilePhoto.jpg")
                              .getDownloadURL(),
                        );
                        emit(
                          UserLogged(u, value.reference),
                        );
                        prefs.setString(
                          "user",
                          jsonEncode(
                            u.toJson(),
                          ),
                        );
                        userSnapshot = value.reference;
                        Navigator.of(event.context).pushReplacement(
                            MaterialPageRoute(
                                builder: (_) => const HomeScreenUser()));
                      }
                    },
                  );
                }
              },
            );
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      emit(UserNotLogged());
      if (e.code == 'user-not-found') {
        showToast("Este Email no esta registrado");
      } else if (e.code == 'wrong-password') {
        showToast("Contraseña Incorrecta");
      }
    } catch (e) {
      showToast(e.toString());
    }
  }
}
