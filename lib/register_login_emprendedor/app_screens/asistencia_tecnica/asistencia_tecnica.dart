//Importamos las librerias necesarias
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import '../../../colors.dart';
import '../../../components/default_button.dart';
import '../../../register_login_emprendedor/conts.dart';
import '../appbar.dart';


//Creamos la clase AsisTec
class AsisTecnicaEmprendedor extends StatefulWidget {
  static String routeName = '/support';

  const AsisTecnicaEmprendedor({Key? key}) : super(key: key);
  @override
  createState() => _PedidosState();
}

class _PedidosState extends State<AsisTecnicaEmprendedor> {
  Color colorIconIngresos = blueDark;
  String state = "Asistencia";
  final TextEditingController _controllerText = TextEditingController();
  int solicitudPedido = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarEmprendedor(
          accion: [], leading: back(context), title: 'Asistencia Técnica'),
      backgroundColor: Colors.white,
      body:
        ListView(
          children: [
            SizedBox(
              height: (MediaQuery.of(context).size.height / 2) - 50,
              child: SvgPicture.asset("assets/images/imagenasistencia.svg"),
            ),
            Text(
              "Descríbenos tu problema",
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                    //width: MediaQuery.of(context).size.width - 40,
                    TextFormField(
                      maxLines: 5,
                      scrollPhysics: const ScrollPhysics(),
                      style:  textStyleGreyName(),
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
                    ),

                  const SizedBox(height: 30.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: ButtonDef(
                        text: "enviar",
                        press: () {

                        }),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15.0),

                
          ],
        ),
    );
  }
}
