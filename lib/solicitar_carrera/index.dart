import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' hide Location;
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:joiedriver/home_user/markersBloc/points_bloc.dart';
import 'package:joiedriver/register_login_user/conts.dart';
import 'package:joiedriver/solicitar_carrera/components/textedit.dart';

import 'pages/selectBank.dart';

class SolicitarCarreraModal extends StatefulWidget {
  const SolicitarCarreraModal({Key? key}) : super(key: key);

  @override
  State<SolicitarCarreraModal> createState() => _SolicitarCarreraModalState();
}

class _SolicitarCarreraModalState extends State<SolicitarCarreraModal> {
  final formKey = GlobalKey<FormState>();

  final data = {};

  Future<Location> getlocationfromaddress(String v) async {
    List<Location> placemarks = await locationFromAddress(v);
    var first = placemarks.first;
    return first;
  }

  void handleSubmit(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      if (data['inicio']) {
        final location =
            (context.read<PositionBloc>().state as PositionObtained).location;
        data['inicio'] = context.read<PointsBloc>().state.pointA ??
            LatLng(location.latitude!, location.longitude!);
      }
      data['destino'] = context.read<PointsBloc>().state.pointB;

      data['pasajeroId'] =
          (context.read<UserBloc>().state as UserLogged).user.email;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SelectPagoScreen(data: data),
        ),
      );
    } else {
      showToast("Verifica los datos e intenta de nuevo");
    }
  }

  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _opacity,
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextField(
                hintText: "Dirección de partida",
                validator: (v) {
                  return null;
                },
                onTap: () async {
                  setState(() {
                    _opacity = 0.0;
                  });
                  final place = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: "AIzaSyAEE30voT1-ycMD3-cxpq2m4oJcKrpLeRA",
                      types: [],
                      mode: Mode.overlay,
                      strictbounds: false,
                      //google_map_webservice package
                      onError: (err) {
                        print(err);
                        setState(() {
                          _opacity = 1.0;
                        });
                      });
                  setState(() {
                    _opacity = 1.0;
                  });
                  if (place != null) {
                    final plist = GoogleMapsPlaces(
                      apiKey: "AIzaSyAEE30voT1-ycMD3-cxpq2m4oJcKrpLeRA",
                      apiHeaders: await const GoogleApiHeaders().getHeaders(),
                      //from google_api_headers package
                    );

                    final detail =
                        await plist.getDetailsByPlaceId(place.placeId!);
                    final coordinates = detail.result.geometry!.location;
                    context.read<PointsBloc>().add(UpdatePoints(
                        LatLng(coordinates.lat, coordinates.lng),
                        context.read<PointsBloc>().state.pointB));
                  }
                },
                icon: "assets/images/A.png",
                onSaved: (value) {
                  data["partida"] = value;
                },
              ),
              CustomTextField(
                validator: (v) {
                  return null;
                },
                hintText: "Dirección de destino",
                icon: "assets/images/B.png",
                onSaved: (value) => data["destino"] = value,
              ),
              CustomTextField(
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Ingresa el monto a ofertar";
                  }
                  if (int.parse(v) < 5000) {
                    return "El monto debe ser mayor a 5000";
                  }
                },
                keyboardType: TextInputType.number,
                hintText: "Monto a ofertar",
                icon: "assets/images/outline_add_a_photo_black_24dp.png",
                onSaved: (value) => data["montoOferta"] = value,
              ),
              CustomTextField(
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Ingresa el número de pasajeros";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                hintText: "Número de pasajeros",
                icon: "assets/images/outline_add_a_photo_black_24dp.png",
                onSaved: (value) => data["pasajeros"] = value,
              ),
              CustomTextField(
                validator: (v) => null,
                hintText: "Necesidad especial",
                icon: "assets/images/outline_add_a_photo_black_24dp.png",
                onSaved: (value) => data["necesidad"] = value,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  color: blue,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(4),
                child: TextButton(
                    onPressed: () {
                      handleSubmit(context);
                    },
                    child: const Text(
                      "Pedir carrera",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
