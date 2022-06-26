import 'package:flutter/material.dart';

import 'conts.dart';

//periquitos del appbar de toda la app
ThemeData themedata() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Montserrat",
    appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: jBase,
        ),
        titleTextStyle: TextStyle(
          color: jBase,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
        )),
    inputDecorationTheme: inputDecorationTheme(),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: jtextColor),
      bodyText2: TextStyle(color: jtextColor),
    ),
  );
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 24,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: const BorderSide(
        color: jBase,
      ),
      gapPadding: 10,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: jBase,
      ),
      gapPadding: 10,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: const BorderSide(
        color: red,
      ),
    ),
  );
}
