import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/carrera/carrera_model.dart';
import 'package:joiedriver/colors.dart';
import 'package:joiedriver/helpers/calculate_distance.dart';

class NuevaCarreraModal extends StatelessWidget {
  const NuevaCarreraModal(
      {Key? key,
      required this.carrera,
      required this.distance,
      required this.polypoints,
      required this.location,
      required this.choferIcon,
      required this.iconPasajero})
      : super(key: key);

  final Carrera carrera;
  final double distance;
  final PolylineResult polypoints;
  final LatLng location;
  final BitmapDescriptor choferIcon;
  final ImageProvider<Object> iconPasajero;

  final TextStyle _text = const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: blue,
                  width: 4,
                ),
              ),
              height: 255,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(carrera.inicio.latitude, carrera.inicio.longitude),
                  zoom: distance < 5
                      ? distance < 3
                          ? 15
                          : 14
                      : 12,
                ),
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("road"),
                    color: Colors.red,
                    points: polypoints.points
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList(),
                  ),
                },
                markers: {
                  Marker(
                      markerId: const MarkerId('inicio'),
                      position: carrera.inicio,
                      infoWindow: InfoWindow(
                          title: 'Inicio',
                          snippet:
                              "${calculateDistance(location, carrera.inicio).toStringAsFixed(2)}KM")),
                  Marker(
                    markerId: const MarkerId('actual'),
                    position: location,
                    icon: choferIcon,
                  ),
                  Marker(
                      markerId: const MarkerId('fin'),
                      position: carrera.destino,
                      infoWindow: InfoWindow(
                          title: 'Destino',
                          snippet:
                              "${calculateDistance(location, carrera.destino).toStringAsFixed(2)}KM")),
                },
              ),
            ),
            Row(children: [
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  width: 60,
                  height: 60,
                  child: CircleAvatar(
                    backgroundColor: blue,
                    foregroundImage: iconPasajero,
                    radius: 10,
                  )),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Image.asset("assets/images/A.png")),
                    Text(
                      'Centro',
                      style: _text,
                    ),
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Image.asset("assets/images/B.png")),
                    Text(
                      'Las Margaritas',
                      style: _text,
                    ),
                  ],
                )
              ])
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Número de pasajeros: ${carrera.numeroPasajeros}'),
                Text('Necesidad especial: ${carrera.condicionEspecial}'),
              ],
            ),
            InkWell(
              onTap: () {},
              overlayColor: MaterialStateColor.resolveWith((states) => blue),
              child: const Text('Aceptar por 50.000 \$'),
            ),
            Text('Forma de pago ${carrera.metodoPago}'),
          ],
        ),
      ),
    );
  }
}
