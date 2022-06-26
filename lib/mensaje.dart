
class Mensaje {
  final String usuario;
  final String mensaje;
  final DateTime fecha;

  Mensaje(this.mensaje,this.fecha, this.usuario);

  Mensaje.fromJson(Map<dynamic, dynamic> json)
    : fecha = DateTime.parse(json['fecha'] as String),
      mensaje = json['mensaje'] as String,
      usuario  = json['emisor'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'fecha': fecha.toString(),
    'mensaje': mensaje,
    'emisor' : usuario,
  };
}