import 'dart:convert';
import 'dart:io';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Antecedents/antecedentes.dart';
import '../cedula/cedula.dart';
import '../document_id/document_id.dart';
import '../profile_photo/profile_photo.dart';
import '../registro/user_data_register.dart';

void recoverProgressPasajero(context) async {
  final prefs = await EncryptedSharedPreferences().getInstance();
  if (prefs.getString("locationRegister") != null) {
    final ImagePicker _picker = ImagePicker();
    Widget yes = const Text("");
    final RegisterUser userRegister =
        RegisterUser.fromJson(jsonDecode(prefs.getString(
      "userRegister",
    )!));
    switch (prefs.getString("locationRegister")!) {
      case 'cedulaPhotoR':
        yes = DocumentId(userRegister);
        break;
    }
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => yes));
  }
}
