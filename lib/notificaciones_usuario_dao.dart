import 'package:firebase_database/firebase_database.dart';
import 'mensaje.dart';

class NotificacionUsuarioDAO {
  static void guardarMensaje(Mensaje mensaje, String usuario) {
    final DatabaseReference _mensajesRef =
        FirebaseDatabase.instance.ref('quejas/pasajero/$usuario');
    _mensajesRef.push().set(mensaje.toJson());
  }

  Query getMensajes(String usuario) {
    final DatabaseReference _mensajesRef =
        FirebaseDatabase.instance.ref('quejas/pasajero/$usuario');
    return _mensajesRef;
  }

  Query getMensajesEmprendedor(String usuario) {

    final DatabaseReference _mensajesRef =
    FirebaseDatabase.instance.ref('quejas/emprendedor/$usuario');
    print(usuario);
    return _mensajesRef;
  }
}
