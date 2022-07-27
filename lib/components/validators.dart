import 'dart:async';
import '../register_login_chofer/conts.dart';

class Valitor {
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      final List<String> errors = [];
      if (password.isEmpty && errors.contains(passNull)) {
        sink.addError(passNull);
      } else if (password.length < 8 && errors.contains(passError)) {
        sink.addError(passError);
      }
    },
  );
}
