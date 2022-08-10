import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../colors.dart';
import 'components/functions.dart';
import 'components/widgets_adicionales.dart';

class VerifyScreen extends StatelessWidget {
  final int code; //codigo generado en el registro
  final String email; //email obtenido del registro
  //el controlador del campo de texto donde el usuario insertara el codigo de verificacion
  final TextEditingController codeFromUser = TextEditingController();

  //Aca tenemos que se requieren los valores email y code obtenidos del
  // registro para asi poder enviar codigo y verificar el correo electronico
  VerifyScreen({Key? key, required this.email, required this.code})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left, size: 30,)),
        title: const Center(child: Text('Verificar correo')),
      ),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Por su seguridad y la nuestra verifique su correo electrónico",
              style: TextStyle(
                color: Colors.blue[700],
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 10,  right: 10),
              child: Text(
                "Ingrese el código que enviamos a su email:",
                style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/correo.svg", height: 20, color: Colors.grey[700],),

                Text(
                  " $email",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            //Llamamos al campo de texto donde el usuario insertara el codigo que le llego a su correo
            const SizedBox(
              height: 10,
            ),
            formCode(codeFromUser),
            SvgPicture.asset("assets/images/ilustracion.svg"),
            //Lllamamos al widget btn() y como primer parametro (string) le pasamos "Verificar"
            // y como segundo parametro (funcion) le pasamos verifyCode() para que realice una
            // comparacion entre code.toString (es decir el valor que se generó en el registro
            // y fue enviado al correo) y codeFromUser.text (el codigo que el usuario ingresa en
            // el campo de texto)
            const SizedBox(
              height: 10,
            ),
            btn("Verificar", () => verifyCode(code.toString(), codeFromUser.text)),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
