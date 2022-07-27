
import 'package:firebase_database/firebase_database.dart';
import 'calificacion_estrellas.dart';

class CalificacionEstrellaDao {

  static void guardarMensaje(CalificacionEstrella calificacion, ) {
    final DatabaseReference _mensajesRef = FirebaseDatabase.instance.reference()
        .child('calificaciones/${calificacion.usuarioReceptor}');
    _mensajesRef.update(calificacion.toJson());

    final DatabaseReference _mensajesRefIndividual = FirebaseDatabase.instance.reference()
        .child('calificaciones/${calificacion.usuarioReceptor}/calificaciones');
    _mensajesRefIndividual.push().set(calificacion.toJson2());

  }

  Query getMensajes(String usuario, String id_chat) {
    final DatabaseReference _mensajesRef = FirebaseDatabase.instance.reference()
        .child('quejas/pasajero/$usuario/$id_chat/chat');
    return  _mensajesRef;
  }

}