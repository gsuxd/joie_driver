import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              icon: Image.asset(
                "assets/images/A.png",
                width: 30,
                color: Colors.grey,
              ),
              onSaved: (value) => data["partida"] = value,
            ),
            CustomTextField(
              hintText: "Dirección de destino",
              icon: Image.asset(
                "assets/images/B.png",
                width: 30,
                color: Colors.grey,
              ),
              onSaved: (value) => data["destino"] = value,
            ),
            CustomTextField(
              hintText: "Monto a ofertar",
              icon: const Icon(
                Icons.monetization_on_outlined,
                size: 32,
              ),
              onSaved: (value) => data["partida"] = value,
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
              child: TextButton(
                  onPressed: () {
                    handleSubmit(context);
                  },
                  child: const Text("Pedir carrera")),
            )
          ],
        ),
      ),
    );
  }
}
