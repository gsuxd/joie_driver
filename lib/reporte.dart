class Reporte {
  final String usuario;
  final String tipo;
  final String problema;
  final String descipcion;
  final DateTime fecha;
  static const String _sms = "Estamos trabajando en solucionar tu problema, en la brevedad uno de nuestros asesores te contestarán";
  static const String _emisor = "asistente";

  Reporte(this.usuario, this.tipo, this.problema, this.descipcion, this.fecha);

  Reporte.fromJson(Map<dynamic, dynamic> json)
  :     fecha = DateTime.parse(json['fecha'] as String),
        usuario = json['usuario'] as String,
        tipo = json['tipo'] as String,
        problema = json['problema'] as String,
        descipcion = json['descipcion'] as String;

  static final Map<dynamic, dynamic> _sms_ini = {
    'emisor': _emisor,
    'mensaje' : _sms,
    'fecha' : DateTime.now().toString(),
  };

  Map<dynamic, dynamic> chat = {'--zzzzini': _sms_ini};

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'problema' : problema,
    'descipcion' : descipcion,
    'fecha' : fecha.toString(),
    'chat' : chat,

  };
}