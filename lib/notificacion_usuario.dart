
class Notificacion {
  final String descripcion;
  final String problema;
  final DateTime fecha;

  Notificacion(this.problema,this.fecha, this.descripcion);

  Notificacion.fromJson(Map<dynamic, dynamic> json)
      : fecha = DateTime.parse(json['fecha'] as String),
        problema = json['problema'] as String,
        descripcion  = json['descipcion'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'fecha': fecha.toString(),
    'problema': problema,
    'descipcion' : descripcion,
  };
}