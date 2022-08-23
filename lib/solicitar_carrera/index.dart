import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/markers/markers_bloc.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';
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

  String _directionInicio = "Cargando";

  void getCity(BuildContext context) async {
    final locationData =
        (context.read<PositionBloc>().state as PositionObtained).location;
    List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData.latitude!, locationData.longitude!);
    var first = placemarks.first;
    setState(() {
      _directionInicio = first.street!;
    });
  }

  getlocationfromaddress(String v) async {
    List<Location> placemarks = await locationFromAddress(v);
    var first = placemarks.first;
    return first;
  }

  @override
  void initState() {
    getCity(context);
    super.initState();
  }

  void handleSubmit(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SelectPagoScreen(data: data),
        ),
      );
    } else {
      showToast("Verifica los datos e intenta de nuevo");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 520,
      decoration: BoxDecoration(
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
              icon: "assets/images/A.png",
              value: _directionInicio,
              onSaved: (value) {
                data["partida"] = value;
              },
            ),
            CustomTextField(
              validator: (v) {
                if (v!.isEmpty) {
                  return "Ingresa una dirección";
                }
                if (getlocationfromaddress(v) == null) {
                  return "Ingresa una dirección válida";
                }
                return null;
              },
              hintText: "Dirección de destino",
              icon: "assets/images/B.png",
              onSaved: (value) => data["destino"] = value,
            ),
            CustomTextField(
              validator: (v) {
                if (v!.isEmpty) {
                  return "Ingresa una dirección";
                }
                return null;
              },
              keyboardType: TextInputType.number,
              hintText: "Monto a ofertar",
              icon: "assets/images/outline_add_a_photo_black_24dp.png",
              onSaved: (value) => data["montoOferta"] = value,
            ),
            CustomTextField(
              validator: (v) {
                if (v!.isEmpty) {
                  return "Ingresa un monto a ofertar";
                }
                return null;
              },
              keyboardType: TextInputType.number,
              hintText: "Número de passajeros",
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
    );
  }
}
