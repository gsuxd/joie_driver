class CalificacionEstrella {
  final String usuarioEmisor;
  final String usuarioReceptor;
  final DateTime fecha;
  final double calificacion;
  final double calificacionIndividual;

  CalificacionEstrella({required this.usuarioReceptor,required this.fecha, required this.usuarioEmisor, required this.calificacion, required this.calificacionIndividual});

  CalificacionEstrella.fromJson(Map<dynamic, dynamic> json)
      : fecha = DateTime.parse(json['fecha'] as String),
        usuarioReceptor = "",
        usuarioEmisor  = "",
        calificacion = json['calificacion'] as double,
        calificacionIndividual = 0.0;


  Map<String, dynamic> toJson() => <String, dynamic>{
    'calificacion' : calificacion,
  };

  Map<dynamic, dynamic> toJson2() => <dynamic, dynamic>{
    'usuario' : usuarioEmisor,
    'calificacion' : calificacionIndividual,
    'fecha' : fecha.toString(),
  };
}