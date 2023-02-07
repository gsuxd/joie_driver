import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:joiedriver/helpers/generate_random_string.dart';
import 'package:joiedriver/helpers/get_user_collection.dart';
import 'package:joiedriver/registro/bloc/registro_data.dart';
import 'package:joiedriver/registro/bloc/registro_enums.dart';
import 'package:joiedriver/registro/pages/antecedentes/antecedentes.dart';
import 'package:joiedriver/registro/pages/foto_vehiculo/foto_vehiculo.dart';
import 'package:joiedriver/registro/pages/tarjeta_propiedad/carta_propiedad.dart';
import 'package:joiedriver/registro/pages/cedula/cedula.dart';
import 'package:joiedriver/registro/pages/cedulaAlreves/cedula_alreves.dart';
import 'package:joiedriver/registro/pages/datos_bancos/datos_banco.dart';
import 'package:joiedriver/registro/pages/licencia/licencia.dart';
import 'package:joiedriver/registro/pages/profile_photo/profile_photo.dart';
import 'package:joiedriver/registro/pages/registro/registro.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/terminos_condiciones/terminos_condiciones.dart';

part 'registro_event.dart';
part 'registro_state.dart';

class RegistroBloc extends Bloc<RegistroEvent, RegistroState> {
  RegistroBloc() : super(RegistroInitial()) {
    on<InitializeRegistroEvent>(_initialize);
    on<NextScreenRegistroEvent>(_nextScreen);
    on<ResumeRegistroEvent>(_handleResume);
    on<EnviarRegistroEvent>(_registerData);
  }

  void _initialize(
      InitializeRegistroEvent event, Emitter<RegistroState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("userRegistroData")) {
      final parsed = RegistroData.fromJson(
          jsonDecode(prefs.getString("userRegistroData")!));
      emit(ResumeRegistroState(parsed));
      return;
    }
    final user = RegistroData(
      name: "",
      address: "",
      code: "",
      date: "",
      email: "",
      lastStep: "basicData",
      genero: "",
      lastName: "",
      referenceCode: "",
      password: "",
      phone: "",
      type: event.userType,
      registroDataBank: RegistroDataBank(),
      registroDataVehiculo: RegistroDataVehiculo(marca: '', placa: ''),
    );
    emit(UpdateRegistroState(user));
    Navigator.of(event.ctx)
        .push(MaterialPageRoute(builder: (_) => const TerminosCondiciones()));
    return;
  }

  Widget getPage(String pageName) {
    switch (pageName) {
      case "profilePhoto":
        return const ProfilePhoto();
      case "registroPage":
        return const RegistroPage();
      case "licencia":
        return const Licencia();
      case "datosBanco":
        return const DatosBanco();
      case "cedula":
        return const Cedula();
      case "cedulaR":
        return const CedulaR();
      case "cartaPropiedad":
        return const CartaPropiedad();
      case "fotoVehiculo":
        return const FotoVehiculo();
      case "antecedentes":
        return const Antecedentes();
      default:
        return const TerminosCondiciones();
    }
  }

  void _handleResume(
      ResumeRegistroEvent event, Emitter<RegistroState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final data = await compute(RegistroData.fromJson,
        jsonDecode(prefs.getString("userRegistroData")!));
    final Widget page = getPage(data.lastStep);
    emit(UpdateRegistroState(data));
    Navigator.of(event.ctx).push(MaterialPageRoute(builder: (_) => page));
    return;
  }

  ///Guarda Progreso y navega a la siguiente pantalla
  void _nextScreen(
      NextScreenRegistroEvent event, Emitter<RegistroState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    event.data.lastStep = event.ctx.widget.toString();
    await prefs.setString("userRegistroData", jsonEncode(event.data.toJson()));
    emit(UpdateRegistroState(event.data));
    if (event.page.toString() == "loading") {
      event.ctx
          .read<RegistroBloc>()
          .add(EnviarRegistroEvent(event.ctx, event.data));
      Navigator.of(event.ctx)
          .pushReplacement(MaterialPageRoute(builder: (_) => event.page));
      return;
    }
    Navigator.of(event.ctx).push(MaterialPageRoute(builder: (_) => event.page));
    return;
  }

  void _registerData(
      EnviarRegistroEvent event, Emitter<RegistroState> emit) async {
    emit(const LoadingRegistroState("Registrando Usuario..."));
    try {
      ///Registrando usuario en Firebase Auth
      if (!(event.isReanuded)) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.data.email, password: event.data.password);
      }

      emit(const LoadingRegistroState("Guardando datos..."));

      ///Guardando datos en Firestore
      final collection = getUserCollection(event.data.type.name);
      final Map<String, dynamic> json = {
        'name': event.data.name.toUpperCase(),
        'lastname': event.data.lastName.toUpperCase(),
        'datebirth': event.data.date,
        'gender': event.data.genero.toUpperCase(),
        'phone': event.data.phone,
        'address': event.data.address,
        'parent': event.data.referenceCode,
        'code': generateRandomString(10)
      };
      if (event.data.type != UserType.pasajero) {
        json.addAll({
          'metodoPago': {
            'nameComplete': event.data.registroDataBank!.nameComplete,
            'number_bank': event.data.registroDataBank!.numberBank,
            'number_ci': event.data.registroDataBank!.numberCi,
            'type_bank': event.data.registroDataBank!.typeBank,
            'bank': event.data.registroDataBank!.bank,
            'date_ci': event.data.registroDataBank!.dateCi,
          }
        });
      }
      if (event.data.type == UserType.chofer) {
        json.addAll({
          'carrerasIgnoradas': [],
          'vehicle': {
            'default': {
              'year': 0,
              'capacity': 0,
              'color': '',
              'brand': event.data.registroDataVehiculo!.marca,
              'plate': event.data.registroDataVehiculo!.placa.toUpperCase(),
            }
          }
        });
      }
      await collection.doc(event.data.email).set(json);

      ///Subida de imagenes
      final int count = event.data.type == UserType.chofer ? 6 : 3;
      emit(LoadingRegistroState("Subiendo imágenes (1/$count)..."));
      await FirebaseStorage.instance
          .ref()
          .child(event.data.email)
          .child('/ProfilePhoto.jpg')
          .putFile(event.data.photoPerfil!);
      emit(LoadingRegistroState("Subiendo imágenes (2/$count)..."));
      await FirebaseStorage.instance
          .ref()
          .child(event.data.email)
          .child('/Cedula.jpg')
          .putFile(event.data.cedula!);
      emit(LoadingRegistroState("Subiendo imágenes (3/$count)..."));
      await FirebaseStorage.instance
          .ref()
          .child(event.data.email)
          .child('/CedulaR.jpg')
          .putFile(event.data.cedulaR!);
      if (event.data.type == UserType.chofer) {
        emit(LoadingRegistroState("Subiendo imágenes (4/$count)..."));
        await FirebaseStorage.instance
            .ref()
            .child(event.data.email)
            .child('/Vehicle.jpg')
            .putFile(event.data.registroDataVehiculo!.documentVehicle!);
        emit(LoadingRegistroState("Subiendo imágenes (5/$count)..."));
        await FirebaseStorage.instance
            .ref()
            .child(event.data.email)
            .child('/TarjetaPropiedad.jpg')
            .putFile(
                event.data.registroDataVehiculo!.documentTarjetaPropiedad!);
        emit(LoadingRegistroState("Subiendo imágenes (6/$count)..."));
        await FirebaseStorage.instance
            .ref()
            .child(event.data.email)
            .child('/Licencia.jpg')
            .putFile(event.data.registroDataVehiculo!.licencia!);
      }
      if (event.data.documentAntecedentes != null) {
        emit(const LoadingRegistroState("Subiendo antecedentes..."));
        await FirebaseStorage.instance
            .ref()
            .child(event.data.email)
            .child('/Antecent.pdf')
            .putFile(event.data.documentAntecedentes!);
      }

      ///Limpieza e inicio de sesión
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      event.ctx.read<UserBloc>().add(
          LoginUserEvent(event.data.email, event.data.password, event.ctx));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {}
      emit(const ErrorRegistroState("Este correo ya esta en uso"));
      return;
    } catch (e) {
      emit(ErrorRegistroState(e.toString()));
      return;
    }
  }
}
