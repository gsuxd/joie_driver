import 'package:flutter/material.dart';
import 'package:joiedriver/register_login_user/conts.dart';
import 'package:joiedriver/solicitar_carrera/components/textedit.dart';

import 'pages/selectBank.dart';

class SolicitarCarreraModal extends StatelessWidget {
  SolicitarCarreraModal({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  final data = {};

  void handleSubmit(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
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
      height: MediaQuery.of(context).size.height * 0.63,
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
              icon: "assets/images/A.png",
              onSaved: (value) => data["partida"] = value,
            ),
            CustomTextField(
              hintText: "Dirección de destino",
              icon: "assets/images/B.png",
              onSaved: (value) => data["destino"] = value,
            ),
            CustomTextField(
              hintText: "Monto a ofertar",
              icon: "assets/images/outline_add_a_photo_black_24dp.png",
              onSaved: (value) => data["montoOferta"] = value,
            ),
            CustomTextField(
              hintText: "Número de passajeros",
              icon: "assets/images/outline_add_a_photo_black_24dp.png",
              onSaved: (value) => data["pasajeros"] = value,
            ),
            CustomTextField(
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
