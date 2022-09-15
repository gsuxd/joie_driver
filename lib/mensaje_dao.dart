import 'package:firebase_database/firebase_database.dart';
import 'mensaje.dart';

class MensajeDAO {

  static void guardarMensaje(Mensaje mensaje, String usuario, String id_chat) {
    final DatabaseReference _mensajesRef = FirebaseDatabase.instance.ref()
        .child('quejas/pasajero/$usuario/$id_chat/chat');
    _mensajesRef.push().set(mensaje.toJson());
  }

  static void guardarMensajeEmprendedor(Mensaje mensaje, String usuario, String id_chat) {
    final DatabaseReference _mensajesRef = FirebaseDatabase.instance.ref()
        .child('quejas/emprendedor/$usuario/$id_chat/chat');
    _mensajesRef.push().set(mensaje.toJson());
  }

  Query getMensajes(String usuario, String id_chat) {
    final DatabaseReference _mensajesRef = FirebaseDatabase.instance.ref()
        .child('quejas/pasajero/$usuario/$id_chat/chat');
    return  _mensajesRef;
  }

  Query getMensajesEmprendedor(String usuario, String id_chat) {
    final DatabaseReference _mensajesRef = FirebaseDatabase.instance.ref()
        .child('quejas/emprendedor/$usuario/$id_chat/chat');
    return  _mensajesRef;
  }

}