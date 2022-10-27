import 'dart:convert';
import 'dart:io';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Antecedents/antecedentes.dart';
import '../carta_propiedad/propiedad.dart';
import '../cedula/cedula.dart';
import '../cedulaAlreves/profile_photo.dart';
import '../licencia/licencia.dart';
import '../profile_photo/profile_photo.dart';
import '../registro/conductor_data_register.dart';
import '../tarjeta_propiedad/card_propierty.dart';

void recoverProgressChofer(context) async {
  final prefs = await EncryptedSharedPreferences().getInstance();
  if (prefs.getString("locationRegister") != null) {
    Widget yes = const Text("");
    final RegisterConductor userRegister =
        RegisterConductor.fromJson(jsonDecode(prefs.getString(
      "userRegister",
    )!));
    switch (prefs.getString("locationRegister")!) {
      default:
        {
          yes = PropiedadScreen(userRegister);
          break;
        }
    }
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => yes));
  }
}
