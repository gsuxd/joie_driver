import 'package:firebase_database/firebase_database.dart';
import 'calificacion_estrellas.dart';

class CalificacionEstrellaDao {
  static void guardarMensaje(
    CalificacionEstrella calificacion,
  ) {
    final DatabaseReference _mensajesRef = FirebaseDatabase.instance
        .ref()
        .child('calificaciones/${calificacion.usuarioReceptor}');
    _mensajesRef.update(calificacion.toJson());

    final DatabaseReference _mensajesRefIndividual = FirebaseDatabase.instance
        .ref()
        .child('calificaciones/${calificacion.usuarioReceptor}/calificaciones');
    _mensajesRefIndividual.push().set(calificacion.toJson2());
  }

  Query getMensajes(String usuario, String idChat) {
    final DatabaseReference _mensajesRef = FirebaseDatabase.instance
        .ref()
        .child('quejas/pasajero/$usuario/$idChat/chat');
    return _mensajesRef;
  }
}
