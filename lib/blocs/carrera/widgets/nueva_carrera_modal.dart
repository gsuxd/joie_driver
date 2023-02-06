import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/carrera/carrera_model.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:joiedriver/colors.dart';
import 'package:joiedriver/helpers/calculate_distance.dart';

import '../carrera_bloc.dart';

class NuevaCarreraModal extends StatefulWidget {
  const NuevaCarreraModal(
      {Key? key,
      required this.carrera,
      required this.carreraRef,
      required this.distance,
      required this.polypoints,
      required this.location,
      required this.aPoint,
      required this.bPoint,
      required this.choferIcon,
      required this.iconPasajero})
      : super(key: key);

  final Carrera carrera;
  final DocumentReference<Map<String, dynamic>> carreraRef;
  final double distance;
  final PolylineResult polypoints;
  final LatLng location;
  final BitmapDescriptor choferIcon;
  final ImageProvider<Object> iconPasajero;
  final BitmapDescriptor aPoint;
  final BitmapDescriptor bPoint;

  @override
  State<NuevaCarreraModal> createState() => _NuevaCarreraModalState();
}

class _NuevaCarreraModalState extends State<NuevaCarreraModal> {
  final TextStyle _text = const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  late dynamic metodoPago;

  @override
  void initState() {
    switch (widget.carrera.metodoPago) {
      case 'efectivo':
        metodoPago = 'Dinero en efectivo';
        break;
      case 'bbva':
        metodoPago = SvgPicture.asset(
          'assets/images/bbva.svg',
          height: 20,
        );
        break;
      case 'bancolombia':
        metodoPago = SvgPicture.asset(
          'assets/images/bancolombia.svg',
          height: 20,
        );
        break;
      case 'davivienda':
        metodoPago = SvgPicture.asset(
          'assets/images/Davivienda.svg',
          height: 20,
        );
        break;
      case 'colpatria':
        metodoPago = SvgPicture.asset(
          'assets/images/colpatria.svg',
          height: 20,
        );
        break;
      case 'bancoDeBogota':
        metodoPago = SvgPicture.asset(
          'assets/images/bogotabank.svg',
          height: 20,
        );
        break;
      case 'nequi':
        metodoPago = SvgPicture.asset(
          'assets/images/nequi.svg',
          height: 20,
        );
        break;
      default:
    }
    super.initState();
  }

  final _pricesList = [
    "50\$",
    "+5%",
    "+10%",
    "+20%",
    "+30%",
    "+50%",
  ];

  int selectedIndex = 0;

  void _ignoreCarrera() async {
    await (context.read<UserBloc>().state as UserLogged)
        .documentReference
        .update({
      'carrerasIgnoradas': FieldValue.arrayUnion([widget.carreraRef.id]),
    });
  }

  @override
  void dispose() {
    _ignoreCarrera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10).copyWith(left: 25, right: 25),
          child: Column(
            children: [
              _CustomMap(
                carrera: widget.carrera,
                choferIcon: widget.choferIcon,
                distance: widget.distance,
                polypoints: widget.polypoints,
                location: widget.location,
                aPoint: widget.aPoint,
                bPoint: widget.bPoint,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(children: [
                SizedBox(
                    width: 60,
                    height: 60,
                    child: CircleAvatar(
                      backgroundColor: blue,
                      foregroundImage: widget.iconPasajero,
                      radius: 10,
                    )),
                const SizedBox(
                  width: 5,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Image.asset("assets/images/A.png")),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.carrera.refInicio.isEmpty
                            ? widget.carrera.refInicio
                            : "No especifica",
                        style: _text,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Image.asset("assets/images/B.png")),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.carrera.refDestino.isEmpty
                            ? widget.carrera.refDestino
                            : "No especifica",
                        style: _text,
                      ),
                    ],
                  )
                ])
              ]),
              const SizedBox(
                height: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Número de pasajeros: ${widget.carrera.numeroPasajeros}',
                        style: _text.copyWith(
                            color: blue, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Text(
                    'Necesidad especial: ${widget.carrera.condicionEspecial}',
                    style: _text.copyWith(
                        color: blue, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SelectTimePage(
                        carreraRef: widget.carreraRef,
                        price: _pricesList[selectedIndex],
                      ),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.all(15).copyWith(left: 25, right: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: blue,
                  ),
                  child: Text('Aceptar por 50.000 \$',
                      style: _text.copyWith(color: Colors.white, fontSize: 20)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Método de pago: ',
                    style: _text.copyWith(
                        color: blue, fontWeight: FontWeight.w700),
                  ),
                  if (metodoPago is String) ...[
                    Text(
                      metodoPago,
                      style: _text.copyWith(
                          color: blue, fontWeight: FontWeight.w700),
                    ),
                  ] else ...[
                    Text(
                      "Transferencia bancaria por",
                      style: _text.copyWith(
                          color: blue, fontWeight: FontWeight.w700),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        child: metodoPago,
                      ),
                    )
                  ]
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ofrezca su precio de viaje',
                    style: _text.copyWith(
                        fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (i) => _CustomButton(
                    text: _pricesList[i],
                    selected: _pricesList[selectedIndex] == _pricesList[i],
                    onTap: () {
                      setState(() {
                        selectedIndex = i;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomMap extends StatelessWidget {
  const _CustomMap(
      {Key? key,
      required this.carrera,
      required this.choferIcon,
      required this.distance,
      required this.polypoints,
      required this.location,
      required this.aPoint,
      required this.bPoint})
      : super(key: key);

  final Carrera carrera;
  final double distance;
  final PolylineResult polypoints;
  final LatLng location;
  final BitmapDescriptor choferIcon;
  final BitmapDescriptor aPoint;
  final BitmapDescriptor bPoint;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          target: LatLng(carrera.inicio.latitude, carrera.inicio.longitude),
          zoom: distance < 5
              ? distance < 3
                  ? 15
                  : 14
              : 12,
        ),
        polylines: {
          Polyline(
            polylineId: const PolylineId("road"),
            color: Colors.blue,
            points: polypoints.points
                .map((e) => LatLng(e.latitude, e.longitude))
                .toList(),
          ),
        },
        markers: {
          Marker(
              markerId: const MarkerId('inicio'),
              position: carrera.inicio,
              icon: aPoint,
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
              icon: bPoint,
              infoWindow: InfoWindow(
                  title: 'Destino',
                  snippet:
                      "${calculateDistance(location, carrera.destino).toStringAsFixed(2)}KM")),
        },
      ),
    );
  }
}

/// Custom button for the prices
/// Takes a [string] and a [boolean] to know if it is selected
/// and a function to execute when it is pressed
class _CustomButton extends StatelessWidget {
  const _CustomButton({
    Key? key,
    required this.text,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final Function() onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(7).copyWith(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: blue,
        ),
        child: Text(text,
            style: TextStyle(
                color: selected ? Colors.black : Colors.white, fontSize: 18)),
      ),
    );
  }
}

class SelectTimePage extends StatefulWidget {
  const SelectTimePage(
      {Key? key, required this.carreraRef, required this.price})
      : super(key: key);
  final DocumentReference<Map<String, dynamic>> carreraRef;
  final String price;
  @override
  State<SelectTimePage> createState() => _SelectTimePageState();
}

class _SelectTimePageState extends State<SelectTimePage> {
  final TextEditingController _controller = TextEditingController();
  void _onTap(int time) {
    if (context.read<CarreraBloc>().state is! CarreraLoading) {
      if (time == 20) {
        showModalBottomSheet(
            context: context,
            builder: (_) => Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText:
                                "Introduce el tiempo de llegada en minutos"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            context.read<CarreraBloc>().add(OfertarCarreraEvent(
                                widget.carreraRef,
                                widget.price,
                                int.parse(_controller.text)));
                          },
                          child: const Text(
                            "Listo",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ));
      } else {
        context
            .read<CarreraBloc>()
            .add(OfertarCarreraEvent(widget.carreraRef, widget.price, time));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Seleccionar tiempo'),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  _onTap(3);
                },
                child: const Text('3 min')),
            ElevatedButton(
                onPressed: () {
                  _onTap(5);
                },
                child: const Text('5 min')),
            ElevatedButton(
                onPressed: () {
                  _onTap(10);
                },
                child: const Text('10 min')),
            ElevatedButton(
                onPressed: () {
                  _onTap(15);
                },
                child: const Text('15 min')),
            ElevatedButton(
                onPressed: () {
                  _onTap(20);
                },
                child: const Text('mas')),
          ],
        ));
  }
}
