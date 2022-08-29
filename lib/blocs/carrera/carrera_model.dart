import 'package:google_maps_flutter/google_maps_flutter.dart';

class Oferta {
  final String chofer;
  final String choferId;
  final String thumb;
  final double calificacion;
  final double precio;

  Oferta(
      {required this.chofer,
      required this.thumb,
      required this.choferId,
      required this.calificacion,
      required this.precio});

  factory Oferta.fromJson(data) => Oferta(
      chofer: data['chofer'],
      thumb: data['thumb'],
      choferId: data['choferId'],
      calificacion: double.parse(data['calificacion']),
      precio: double.parse(data['precio']));

  toJson() => {
        'chofer': chofer,
        'thumb': thumb,
        'choferId': choferId,
        'calificacion': calificacion.toString(),
        'precio': precio.toString()
      };
}

class Carrera {
  final String pasajeroId;
  final int numeroPasajeros;
  final String metodoPago;
  final double precioOfertado;
  final bool aceptada;
  final String? choferId;
  final String? condicionEspecial;
  final LatLng inicio;
  final LatLng destino;
  final DateTime fecha;
  final List<Oferta> ofertas;

  Carrera(
      {required this.aceptada,
      this.choferId,
      required this.numeroPasajeros,
      required this.pasajeroId,
      required this.precioOfertado,
      required this.condicionEspecial,
      required this.metodoPago,
      required this.inicio,
      required this.destino,
      required this.fecha,
      required this.ofertas});

  factory Carrera.fromJson(data) => Carrera(
        aceptada: data['aceptada'],
        choferId: data['choferId'],
        numeroPasajeros: int.parse(data['numeroPasajeros']),
        pasajeroId: data['pasajeroId'],
        precioOfertado: double.parse(data['precioOfertado']),
        condicionEspecial: data['condicionEspecial'],
        metodoPago: data['metodoPago'],
        inicio: LatLng(double.parse(data['inicio']['lat']),
            double.parse(data['inicio']['lng'])),
        destino: LatLng(
          double.parse(
            data['destino']['lat'],
          ),
          double.parse(
            data['destino']['lng'],
          ),
        ),
        fecha: DateTime.parse(data['fecha']),
        ofertas: (data['ofertas'] != null && data['ofertas'].length > 0)
            ? data['ofertas'].map<Oferta>((e) => Oferta.fromJson(e)).toList()
            : [],
      );

  toJson() => {
        'aceptada': aceptada,
        'choferId': choferId,
        'numeroPasajeros': numeroPasajeros.toString(),
        'pasajeroId': pasajeroId,
        'precioOfertado': precioOfertado.toString(),
        'condicionEspecial': condicionEspecial,
        'metodoPago': metodoPago,
        'inicio': {
          'lat': inicio.latitude.toString(),
          'lng': inicio.longitude.toString()
        },
        'destino': {
          'lat': destino.latitude.toString(),
          'lng': destino.longitude.toString()
        },
        'fecha': fecha.toIso8601String(),
        'ofertas': ofertas.map((e) => e.toJson()).toList(),
      };
}
