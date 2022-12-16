import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:joiedriver/home_user/bloc/cars_bloc.dart';
import 'package:joiedriver/register_login_chofer/conts.dart';
import 'package:joiedriver/solicitar_carrera/index.dart';

class MapViewPasajeros extends StatefulWidget {
  const MapViewPasajeros({Key? key}) : super(key: key);

  @override
  State<MapViewPasajeros> createState() => _MapViewPasajerosState();
}

class _MapViewPasajerosState extends State<MapViewPasajeros> {
  late GoogleMapController _controller;

  LatLng? _pointB;
  LatLng? _pointA;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<CarsBloc, CarsState>(
          builder: (context, carsState) {
            return BlocBuilder<PositionBloc, PositionState>(
              builder: (context, positionState) {
                if (positionState is PositionLoading ||
                    carsState is! CarsLoaded) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (positionState is PositionObtained) {
                  return BlocListener<PositionBloc, PositionState>(
                    listener: (context, state) {
                      if (state is PositionObtained) {
                        _controller.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                          zoom: 15,
                          target: LatLng(
                            state.location.latitude!,
                            state.location.longitude!,
                          ),
                        )));
                      }
                    },
                    child: GoogleMap(
                      onTap: (LatLng tap) {
                        setState(() {
                          _pointB = tap;
                        });
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(positionState.location.latitude!,
                            positionState.location.longitude!),
                        zoom: 15,
                      ),
                      markers: {
                        if (_pointB != null)
                          Marker(
                              markerId: const MarkerId('pointB'),
                              position: _pointB!,
                              infoWindow: InfoWindow(
                                  title: "Destino",
                                  onTap: () {
                                    setState(() {
                                      _pointB = null;
                                    });
                                  })),
                        if (_pointA != null)
                          Marker(
                              markerId: const MarkerId('pointA'),
                              position: _pointB!,
                              infoWindow: InfoWindow(
                                  title: "Inicio",
                                  onTap: () {
                                    setState(() {
                                      _pointA = null;
                                    });
                                  })),
                        Marker(
                          markerId: const MarkerId('current_location'),
                          position: LatLng(positionState.location.latitude!,
                              positionState.location.longitude!),
                        ),
                        ...(context.watch<CarsBloc>().state as CarsLoaded).cars
                      },
                      myLocationButtonEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      },
                    ),
                  );
                }
                return const Center(
                  child: Text(
                      "Ocurrió un error obteniendo tu ubicación, porfavor verifica tu conexión a internet y habilita los "),
                );
              },
            );
          },
        ),
        Positioned(
          bottom: 15,
          left: 120,
          child: InkWell(
            onTap: () async {
              showBottomSheet(
                  context: context,
                  backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                  builder: (context) => const SolicitarCarreraModal());
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: blue, width: 5),
                color: const Color.fromRGBO(255, 250, 17, 1),
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.all(5),
              child: SvgPicture.asset(
                "assets/icons/pedirAutoUst.svg",
                width: 130,
                color: blue,
              ),
            ),
          ),
        )
      ],
    );
  }
}
