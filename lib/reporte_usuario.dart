class ReporteUsuario {
  final String usuario_emisor;
  final String usuario_receptor;
  final String nombre_apellido;
  final int category;
  final double calificacionn;
  final String descripcion;
  final DateTime fecha;
  final int n_reportes;

  ReporteUsuario(  { required this.n_reportes, required this.calificacionn,required this.usuario_receptor, required this.nombre_apellido, required this.category, required this.descripcion, required this.fecha, required this.usuario_emisor});

  ReporteUsuario.fromJson(Map<dynamic, dynamic> json,  {this.descripcion = " ", this.usuario_receptor = " ", this.usuario_emisor = " "})
  :     fecha = DateTime.parse(json['fecha'] as String),
        nombre_apellido = json['nombre_apellido'] as String,
        category = json['category'] as int,
        calificacionn = json['calificacion'] as double,
        n_reportes = json['n_reportes'] as int;

  ReporteUsuario.fromJsonIndividual(Map<dynamic, dynamic> json,   {this.calificacionn = 0.0,this.usuario_receptor="", this.n_reportes=0, this.nombre_apellido = " ",})
      : fecha = DateTime.parse(json['fecha'] as String),
        usuario_emisor = json['user'] as String,
        category = json['category'] as int,
        descripcion = json['descripcion'] as String;


  late  Map<dynamic, dynamic> sms_ini = {
    'category': category,
    'descripcion' : descripcion,
    'fecha' : DateTime.now().toString(),
    'user' : usuario_emisor,
  };

  Map<String, dynamic> toJson() => <String, dynamic>{
    'category' : category,
    'nombre_apellido' : nombre_apellido,
    'fecha' : fecha.toString(),
    'calificacion': calificacionn,
    'n_reportes': n_reportes
  };

  Map<dynamic, dynamic> toJsonIndividual() => <dynamic, dynamic>{
    'reportes' : sms_ini,
  };
}