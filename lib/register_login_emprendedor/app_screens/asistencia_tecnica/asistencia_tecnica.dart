import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import '../../../colors.dart';
import '../../../components/button_cancel.dart';
import '../../../components/default_button.dart';
import '../../../register_login_emprendedor/conts.dart';
import '../appbar.dart';
import 'package:joiedriver/reporte.dart';
import 'package:joiedriver/reporte_dao.dart';

import '../ganancias/ganancias.dart';


//Creamos la clase AsisTec
class AsisTecnicaEmprendedor extends StatefulWidget {
  static String routeName = '/support';

  const AsisTecnicaEmprendedor({Key? key}) : super(key: key);
  @override
  createState() => _PedidosState();
}

class _PedidosState extends State<AsisTecnicaEmprendedor> {

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
     getData();

  }

  Future getData() async {
    email = await encryptedSharedPreferences.getString('email');
    email = email.substring(0, email.length-4);
  }
  String email = "None";
  EncryptedSharedPreferences encryptedSharedPreferences =
  EncryptedSharedPreferences();
  final TextEditingController _controllerText = TextEditingController();

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
                      controller: _controllerText,
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
                          if(_controllerText.text.isEmpty){
                            showToast("La Descripción esa Vacía");
                          }else{

                            showDialog<String>(

                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                    title: const Text('¿Seguro que desea Enviar una Solicitud?'),

                                    content: SizedBox(
                                      width: 200.0,
                                      height: 200.0,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 20,),
                                          ButtonDef(text: "Enviar",
                                          press: (){
                                            final _reporte = Reporte(
                                              email,
                                              "Emprendedor",
                                              "Asistencia Ténica",
                                              _controllerText.text,
                                              DateTime.now(),
                                            );
                                            ReporteDao reporteDao = ReporteDao();
                                            reporteDao.guardarReporteEmprendedor(_reporte, email);
                                            _controllerText.clear();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => const Ganancias()));
                                          },
                                          ),
                                          const SizedBox(height: 10,),
                                          ButtonDefCancel(
                                            text: "Cancelar",
                                            press: (){
                                              Navigator.pop(context);
                                            },
                                          ),
                                          const SizedBox(height: 20,),
                                        ],
                                      ),
                                    )));
                          }

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
