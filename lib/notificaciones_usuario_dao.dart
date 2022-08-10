import 'package:firebase_database/firebase_database.dart';
import 'mensaje.dart';

class NotificacionUsuarioDAO {
  static void guardarMensaje(Mensaje mensaje, String usuario) {
    final DatabaseReference _mensajesRef =
        FirebaseDatabase.instance.ref().child('quejas/pasajero/$usuario');
    _mensajesRef.push().set(mensaje.toJson());
  }

  Query getMensajes(String usuario) {
    final DatabaseReference _mensajesRef =
        FirebaseDatabase.instance.ref().child('quejas/pasajero/$usuario');
    return _mensajesRef;
  }
}
