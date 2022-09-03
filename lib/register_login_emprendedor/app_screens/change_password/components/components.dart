import 'package:flutter/material.dart';
import 'package:joiedriver/register_login_chofer/conts.dart';
import '../../../../colors.dart';

TextFormField inputText(hintText, controller) {
  var isHiddenPassword = true;
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      focusColor: Colors.grey,
      //border: InputBorder.none,
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey)),
      //disabledBorder: InputBorder.none,
      focusedBorder:
          const UnderlineInputBorder(borderSide: BorderSide(color: jBase)),
      hintText: hintText,
      hintStyle:
          const TextStyle(color: Colors.black12, fontWeight: FontWeight.bold),
    ),
    obscureText: isHiddenPassword,
  );
}

Text des(text) {
  return Text(
    text,
    style: textStyleGreyName(),
  );
}

ElevatedButton btnContinue(function) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: jBase,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        )),
    onPressed: () async {
      await function();
    },
    child: const Padding(
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 60, right: 60),
      child: Text(
        "Continuar",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ),
  );
}
