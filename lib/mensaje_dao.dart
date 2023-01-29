import 'package:firebase_database/firebase_database.dart';
import 'mensaje.dart';

class MensajeDAO {
  static void guardarMensaje(Mensaje mensaje, String usuario, String idChat) {
    final DatabaseReference _mensajesRef = FirebaseDatabase.instance
        .ref()
        .child('quejas/pasajero/$usuario/$idChat/chat');
    _mensajesRef.push().set(mensaje.toJson());
  }

  Query getMensajes(String usuario, String idChat) {
    final DatabaseReference _mensajesRef = FirebaseDatabase.instance
        .ref()
        .child('quejas/pasajero/$usuario/$idChat/chat');
    return _mensajesRef;
  }

  const MensajeDAO();
}
