import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/singletons/carro_data.dart';

class Oferta {
  final String chofer;
  final String choferId;
  final String thumb;
  final double calificacion;
  final String precio;
  final int tardanza;

  Oferta(
      {required this.chofer,
      required this.thumb,
      required this.choferId,
      required this.calificacion,
      required this.precio,
      required this.tardanza});

  factory Oferta.fromJson(data) => Oferta(
      chofer: data['chofer'],
      thumb: data['thumb'],
      choferId: data['choferId'],
      calificacion: double.parse(data['calificacion']),
      precio: data['precio'],
      tardanza: int.parse(data['tardanza']));

  toJson() => {
        'chofer': chofer,
        'thumb': thumb,
        'choferId': choferId,
        'calificacion': calificacion.toString(),
        'precio': precio,
        'tardanza': tardanza.toString()
      };
}

class Carrera {
  final String pasajeroId;
  final int numeroPasajeros;
  final String metodoPago;
  final VehicleType? tipoVehiculo;
  final double precioOfertado;
  final bool aceptada;
  final String? choferId;
  final String? condicionEspecial;
  final LatLng inicio;
  final String refInicio;
  final String refDestino;
  final LatLng destino;
  final DateTime fecha;
  final List<Oferta> ofertas;
  final bool cancelada;
  final bool finalizada;

  Carrera(
      {required this.aceptada,
      this.choferId,
      this.finalizada = false,
      this.refInicio = '',
      this.refDestino = '',
      required this.numeroPasajeros,
      required this.pasajeroId,
      required this.precioOfertado,
      required this.condicionEspecial,
      required this.metodoPago,
      required this.inicio,
      required this.destino,
      required this.fecha,
      this.tipoVehiculo,
      required this.ofertas,
      this.cancelada = false});

  factory Carrera.fromJson(data) => Carrera(
        aceptada: data['aceptada'],
        tipoVehiculo: VehicleType.values.firstWhere((element) =>
            element.name == (data['tipoVehiculo'] ?? 'particular')),
        choferId: data['choferId'],
        numeroPasajeros: int.parse(data['numeroPasajeros']),
        pasajeroId: data['pasajeroId'],
        finalizada: data['finalizada'],
        refInicio: data['refInicio'],
        refDestino: data['refDestino'],
        precioOfertado: double.parse(data['precioOfertado']),
        condicionEspecial: data['condicionEspecial'],
        metodoPago: data['metodoPago'],
        cancelada: data['cancelada'],
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

  Map<String, dynamic> toJson() => {
        'aceptada': aceptada,
        'choferId': choferId,
        'numeroPasajeros': numeroPasajeros.toString(),
        'pasajeroId': pasajeroId,
        'precioOfertado': precioOfertado.toString(),
        'condicionEspecial': condicionEspecial,
        'metodoPago': metodoPago,
        'tipoVehiculo': tipoVehiculo?.name,
        'finalizada': finalizada,
        'cancelada': cancelada,
        'refInicio': refInicio,
        'refDestino': refDestino,
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
