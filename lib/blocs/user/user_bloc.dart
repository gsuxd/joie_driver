import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:joiedriver/blocs/user/user_enums.dart';
import 'package:joiedriver/conts.dart';
import 'package:joiedriver/home/home.dart';
import 'package:joiedriver/home_user/home.dart';
import 'package:joiedriver/main.dart';
import 'package:joiedriver/singletons/carro_data.dart';
import 'package:joiedriver/singletons/user_data.dart';
import 'package:flutter/material.dart';
import 'package:joiedriver/verificacion/main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoading()) {
    on<LoadUserEvent>(_handleLoadUser);
    on<LoginUserEvent>(_handleLogin);
    on<VerifyUserEvent>(_handleVerify);
  }

  void _handleVerify(VerifyUserEvent event, Emitter<UserState> emit) async {
    switch (event.type) {
      case VerifyType.shareLink:
        final code = await (await userSnapshot.get()).get('code');
        Share.share(
          "Descarga ahora Joie Driver y registrate con mi codigo $code para empezar a viajar donde quieras! https://google.com/",
        );
        break;
      default:
    }
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
    UserData user = UserData.fromJson(jsonDecode(prefs.getString("user")!));
    late DocumentReference<Map<String, dynamic>> userSnapshot;
    userSnapshot =
        FirebaseFirestore.instance.collection("users").doc(user.email);
    userSnapshot.update(
        {"notificationToken": await FirebaseMessaging.instance.getToken()});
    final gettedUser = await userSnapshot.get();
    user = UserData(
      lastName: gettedUser['lastname'],
      name: gettedUser['name'],
      verified: gettedUser['verified'],
      birthDate: gettedUser['datebirth'],
      referralsCode: gettedUser['code'],
      email: FirebaseAuth.instance.currentUser!.email!,
      genero: gettedUser['gender'],
      type: UserType.values
          .firstWhere((element) => element.name == gettedUser["userType"]),
      profilePicture: await FirebaseStorage.instance
          .ref()
          .child(
              "${FirebaseAuth.instance.currentUser!.email!}/ProfilePhoto.jpg")
          .getDownloadURL(),
      carroData: (gettedUser['userType'] == 'chofer')
          ? CarroData(
              brand: gettedUser["vehicle"]['default']['brand'],
              type: VehicleType.values.firstWhere((element) =>
                  element.name == gettedUser["vehicle"]['default']['type']),
              year: gettedUser["vehicle"]['default']['year'].toString(),
              plate: gettedUser["vehicle"]['default']['plate'],
              color: gettedUser["vehicle"]['default']['color'],
              capacity: gettedUser["vehicle"]['default']['capacity'].toString(),
              picture: await FirebaseStorage.instance
                  .ref()
                  .child(FirebaseAuth.instance.currentUser!.email!)
                  .child('/Vehicle.jpg')
                  .getDownloadURL(),
            )
          : null,
    );
    if (user.verified) {
      emit(UserLogged(user, userSnapshot));
    } else {
      emit(UserNotVerified(userSnapshot, user));
    }
  }

  void _handleLogin(LoginUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      final gettedUser = (await FirebaseFirestore.instance
          .doc("users/${user.user!.email}")
          .get());
      if (gettedUser.exists) {
        final u = UserData(
          lastName: gettedUser['lastname'],
          name: gettedUser['name'],
          verified: gettedUser['verified'],
          birthDate: gettedUser['datebirth'],
          referralsCode: gettedUser['code'],
          email: FirebaseAuth.instance.currentUser!.email!,
          genero: gettedUser['gender'],
          type: UserType.values
              .firstWhere((element) => element.name == gettedUser["userType"]),
          profilePicture: await FirebaseStorage.instance
              .ref()
              .child(
                  "${FirebaseAuth.instance.currentUser!.email!}/ProfilePhoto.jpg")
              .getDownloadURL(),
          carroData: (gettedUser['userType'] == 'chofer')
              ? CarroData(
                  brand: gettedUser["vehicle"]['default']['brand'],
                  type: VehicleType.values.firstWhere((element) =>
                      element.name == gettedUser["vehicle"]['default']['type']),
                  year: gettedUser["vehicle"]['default']['year'].toString(),
                  plate: gettedUser["vehicle"]['default']['plate'],
                  color: gettedUser["vehicle"]['default']['color'],
                  capacity:
                      gettedUser["vehicle"]['default']['capacity'].toString(),
                  picture: await FirebaseStorage.instance
                      .ref()
                      .child(FirebaseAuth.instance.currentUser!.email!)
                      .child('/Vehicle.jpg')
                      .getDownloadURL(),
                )
              : null,
        );
        userSnapshot = gettedUser.reference;
        prefs.setString("user", jsonEncode(u.toJson()));
        if (u.type == UserType.chofer) {
          await gettedUser.reference.update({"active": true});
        }
        if (u.type != UserType.pasajero) {
          if (u.verified) {
            emit(UserLogged(u, gettedUser.reference));
            Navigator.of(event.context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (_) => u.type == UserType.chofer
                        ? const HomeScreen()
                        : const HomeScreenUser()),
                (route) => false);
            return;
          } else {
            emit(UserNotVerified(gettedUser.reference, u));
            MyApp.navigatorKey.currentState!.pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const VerificacionPage()),
                (route) => false);
            return;
          }
        }
        MyApp.navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomeScreenUser()),
            (route) => false);
        return;
      }
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
