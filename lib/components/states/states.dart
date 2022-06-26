import 'package:flutter/material.dart';



class EmailNotify extends ChangeNotifier {
  String _email = "email";

  String get value => _email;

  void setEmail(String email) {
    _email = email;
    print("$_email");
    notifyListeners();
  }
}

class CodeNotify extends ChangeNotifier {
  String _code = "Code";

  String get value => _code;

  void setCode(String code) {
    _code = code;
    print("$_code");
    notifyListeners();
  }
}