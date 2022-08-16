import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:joiedriver/register_login_user/conts.dart';
import 'package:joiedriver/singletons/carro_data.dart';
import 'package:joiedriver/singletons/user_data.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoading()) {
    on<LoadUserEvent>(_handleLoadUser);
    on<LoginUserEvent>(_handleLogin);
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
    emit(UserLogged(user));
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
            UserLogged(u);
            prefs.setString("user", jsonEncode(u.toJson()));
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
                    type: "usersPasajeros",
                    profilePicture: await FirebaseStorage.instance
                        .ref()
                        .child(
                            "${FirebaseAuth.instance.currentUser!.email!}/ProfilePhoto.jpg")
                        .getDownloadURL(),
                  );
                  emit(
                    UserLogged(u),
                  );
                  prefs.setString(
                    "user",
                    jsonEncode(
                      u.toJson(),
                    ),
                  );
                  return;
                } else {
                  await FirebaseFirestore.instance
                      .doc("usersEmprendedor/${user.user!.email}")
                      .get()
                      .then(
                    (value) async {
                      if (value.exists) {
                        emit(
                          UserLogged(
                            UserData(
                              lastName: value['lastname'],
                              name: value['name'],
                              birthDate: value['datebirth'],
                              referralsCode: value['code'],
                              email: FirebaseAuth.instance.currentUser!.email!,
                              genero: value['gender'],
                              type: "usersEmprendedor",
                              profilePicture: await FirebaseStorage.instance
                                  .ref()
                                  .child(
                                      "${FirebaseAuth.instance.currentUser!.email!}/ProfilePhoto.jpg")
                                  .getDownloadURL(),
                            ),
                          ),
                        );
                        value.reference.snapshots().listen(
                          (event) {
                            prefs.setString("user", jsonEncode(event.data()!));
                          },
                        );
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
