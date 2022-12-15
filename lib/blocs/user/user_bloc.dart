import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/blocs/carrera/carrera_bloc.dart';
import 'package:joiedriver/blocs/markers/markers_bloc.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:joiedriver/register_login_user/conts.dart';
import 'package:joiedriver/singletons/carro_data.dart';
import 'package:joiedriver/singletons/user_data.dart';
import 'package:flutter/material.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoading()) {
    on<LoadUserEvent>(_handleLoadUser);
    on<LoginUserEvent>(_handleLogin);
    on<LogOutUserEvent>(_handleLogOutUser);
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

  void _handleLogOutUser(LogOutUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final prefs = await EncryptedSharedPreferences().getInstance();
    if (userSnapshot.path.contains("users")) {
      await userSnapshot.update({"active": false});
    }
    prefs.clear();
    await FirebaseAuth.instance.signOut();
    emit(UserNotLogged());
  }

  void _handleLoadUser(LoadUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final prefs = await EncryptedSharedPreferences().getInstance();
    if (prefs.getString("user") == null) {
      emit(UserNotLogged());
      return;
    }
    final UserData user =
        UserData.fromJson(jsonDecode(prefs.getString("user")!));
    switch (user.type) {
      case 'Conductor':
        userSnapshot =
            FirebaseFirestore.instance.collection("users").doc(user.email);
        break;
      case 'Emprendedor':
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
      final prefs = await EncryptedSharedPreferences().getInstance();
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
              type: "Conductor",
              profilePicture: await FirebaseStorage.instance
                  .ref()
                  .child(
                      "${FirebaseAuth.instance.currentUser!.email!}/ProfilePhoto.jpg")
                  .getDownloadURL(),
              carroData: CarroData(
                brand: value["vehicle"]["default"]['brand'],
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
            prefs.setString("user", jsonEncode(u.toJson()));
            emit(UserLogged(u, value.reference));
            // Navigator.of(event.context).pushAndRemoveUntil(
            //     MaterialPageRoute(builder: (_) => const HomeScreenUser()),
            //     (route) => false);
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
                    type: "Pasajero",
                    profilePicture: await FirebaseStorage.instance
                        .ref()
                        .child(
                            "${FirebaseAuth.instance.currentUser!.email!}/ProfilePhoto.jpg")
                        .getDownloadURL(),
                  );
                  prefs.setString(
                    "user",
                    jsonEncode(
                      u.toJson(),
                    ),
                  );
                  userSnapshot = value.reference;
                  emit(
                    UserLogged(u, value.reference),
                  );
                  // Navigator.of(event.context).pushAndRemoveUntil(
                  //     MaterialPageRoute(builder: (_) => const HomeScreenUser()),
                  //     (route) => false);
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
                          type: "Emprendedor",
                          profilePicture: await FirebaseStorage.instance
                              .ref()
                              .child(
                                  "${FirebaseAuth.instance.currentUser!.email!}/ProfilePhoto.jpg")
                              .getDownloadURL(),
                        );
                        prefs.setString(
                          "user",
                          jsonEncode(
                            u.toJson(),
                          ),
                        );
                        userSnapshot = value.reference;
                        emit(
                          UserLogged(u, value.reference),
                        );
                        // Navigator.of(event.context).pushAndRemoveUntil(
                        //     MaterialPageRoute(
                        //         builder: (_) => const HomeScreenUser()),
                        //     (route) => false);
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
