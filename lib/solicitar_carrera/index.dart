import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:joiedriver/register_login_user/conts.dart';
import 'package:joiedriver/solicitar_carrera/components/textedit.dart';
import 'package:joiedriver/solicitar_carrera/models/PlacesResponse.dart';

import 'pages/selectBank.dart';

class SolicitarCarreraModal extends StatefulWidget {
  const SolicitarCarreraModal({Key? key, required this.pointB})
      : super(key: key);

  final LatLng pointB;

  @override
  State<SolicitarCarreraModal> createState() => _SolicitarCarreraModalState();
}

class _SolicitarCarreraModalState extends State<SolicitarCarreraModal> {
  final formKey = GlobalKey<FormState>();

  final data = {};

  void handleSubmit(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      final location =
          (context.read<PositionBloc>().state as PositionObtained).location;
      data['inicio'] = LatLng(location.latitude!, location.longitude!);

      data['destino'] = widget.pointB;

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

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Autocomplete(
              optionsBuilder: (value) async {
                final res = await Dio().get(
                    "https://maps.googleapis.com/maps/api/place/textsearch/json?query=${value.text.replaceAll(" ", "%20")}&key=AIzaSyAEE30voT1-ycMD3-cxpq2m4oJcKrpLeRA");
                final parsed = (res.data['results'] as List<dynamic>).map(
                  (e) => PlacesResponse.fromJson(e),
                );
                return parsed;
              },
              displayStringForOption: (PlacesResponse option) =>
                  option.formattedAddress,
              fieldViewBuilder: (context, textEditingController, focusNode,
                      onFieldSubmitted) =>
                  CustomTextField(
                      hintText: "Dirección de partida",
                      validator: (v) {
                        return null;
                      },
                      icon: "assets/images/A.png",
                      focusNode: focusNode,
                      controller: textEditingController),
              onSelected: (v) {
                data['partida'] = v;
              },
            ),
            Autocomplete(
              optionsBuilder: (value) async {
                final res = await Dio().get(
                    "https://maps.googleapis.com/maps/api/place/textsearch/json?query=${value.text.replaceAll(" ", "%20")}&key=AIzaSyAEE30voT1-ycMD3-cxpq2m4oJcKrpLeRA");
                final parsed = (res.data['results'] as List<dynamic>).map(
                  (e) => PlacesResponse.fromJson(e),
                );
                return parsed;
              },
              displayStringForOption: (PlacesResponse option) =>
                  option.formattedAddress,
              fieldViewBuilder: (context, textEditingController, focusNode,
                      onFieldSubmitted) =>
                  CustomTextField(
                      hintText: "Dirección de destino",
                      validator: (v) {
                        return null;
                      },
                      icon: "assets/images/B.png",
                      focusNode: focusNode,
                      controller: textEditingController),
              onSelected: (v) {
                data['destino'] = v;
              },
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
    );
  }
}
