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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<PositionBloc, PositionState>(
          builder: (context, state) {
            if (state is PositionLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is PositionObtained) {
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
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        state.location.latitude!, state.location.longitude!),
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('current_location'),
                      position: LatLng(
                          state.location.latitude!, state.location.longitude!),
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
        ),
        Positioned(
          bottom: 15,
          left: 135,
          child: InkWell(
            onTap: () {
              showBottomSheet(
                  context: context,
                  builder: (context) => SolicitarCarreraModal());
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: blue, width: 2),
                color: Colors.lightGreen[300],
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.all(5),
              child: SvgPicture.asset(
                "assets/images/request.svg",
                width: 130,
              ),
            ),
          ),
        )
      ],
    );
  }
}
