import 'package:flutter/material.dart';
import 'package:joiedriver/register_login_chofer/conts.dart';

AppBar appBarEmprendedor(
    {required String title,
    required Widget? leading,
    required List<Widget>? accion}) {
  return AppBar(
    backgroundColor: jBase,
    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    leading: leading,
    actions: accion,
  );
}
