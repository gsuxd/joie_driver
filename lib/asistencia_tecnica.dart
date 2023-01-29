import 'package:joiedriver/home_user/home.dart';
import 'package:joiedriver/pedidos.dart';
import 'package:joiedriver/perfil_usuario.dart';
import 'package:joiedriver/reporte.dart';
import 'package:joiedriver/reporte_dao.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';

import 'colors.dart';
import 'main.dart';

class AsistenciaTecnicaUsuario extends StatefulWidget {
  const AsistenciaTecnicaUsuario({Key? key}) : super(key: key);

  @override
  createState() => _PedidosState();
}

class _PedidosState extends State<AsistenciaTecnicaUsuario> {
  Color color_icon_inicio = blue;
  Color color_icon_historial = blue;
  Color color_icon_perfil = blue;
  Color color_icon_ingresos = blue_dark;
  String state = "Asistencia";
  final TextEditingController _controllerText = TextEditingController();
  int solicitudPedido = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: blue,
          leading: Container(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 40,
                )),
          ),
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              state,
              style: const TextStyle(
                  fontFamily: "Monserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
          ]),
          actions: [
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                "assets/images/share.svg",
                height: 40,
                color: Colors.white,
              ),
            ),
            Container(
              width: 10.0,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  "assets/images/imagenasistencia.svg",
                  width: MediaQuery.of(context).size.width,
                ),
                item("Problemas de localizacion",
                    "assets/images/problemas_de_geo_localizacion.svg"),
                Container(
                  height: 15.0,
                ),
                item("No puedo pedir viaje",
                    "assets/images/no_puedo_pedir_carro.svg"),
                Container(
                  height: 15.0,
                ),
                item("Mi cuenta se reinicia",
                    "assets/images/se_reinicia_mi_cuenta.svg"),
                Container(
                  height: 15.0,
                ),
                item("Mi calificacion esta mal",
                    "assets/images/mi_calificacion_esta_mal.svg"),
                Container(
                  height: 15.0,
                ),
                item("No puedo actualizar mis datos",
                    "assets/images/no_puedo_actualizar_mis_datos.svg"),
                Container(
                  height: 15.0,
                ),
                item("Otros", "assets/images/otros.svg"),
              ],
            ),
            Positioned(bottom: 10, left: 0.0, child: bottomNavBar(context))
          ],
        ));
  }

  Widget alert(String title, String icon) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          itemA(title, icon),
          Container(
            height: 20.0,
          ),
          const Text(
            "Puedes describirnos la falla",
            style: TextStyle(
                color: Colors.black87, fontFamily: "Monserrat", fontSize: 14.0),
          ),
          Container(
            height: 90.0,
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            padding: const EdgeInsets.only(
                left: 5.0, right: 5.0, top: 10.0, bottom: 5.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(width: 1, color: blue),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: TextField(
                controller: _controllerText,
                maxLines: 7,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  enabledBorder: OutlineInputBorder(
                    gapPadding: 0.01,
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    borderSide: BorderSide(color: Colors.white, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 0.01,
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    borderSide: BorderSide(color: Colors.white, width: 0),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 10.0,
              ),
              SizedBox(
                height: 22,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _controllerText.clear();
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                  child: const Center(
                      child: Text(
                    "cancelar",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Monserrat",
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              Container(
                width: 10.0,
              ),
              SizedBox(
                height: 22,
                child: ElevatedButton(
                    onPressed: () {
                      final _reporte = Reporte(
                        "UsuarioPrueba",
                        "Pasajero",
                        title,
                        _controllerText.text,
                        DateTime.now(),
                      );
                      ReporteDao reporteDao = const ReporteDao();
                      reporteDao.guardarReporte(_reporte, "UsuarioPrueba");
                      Navigator.pop(context);
                      _controllerText.clear();
                      solicitudPedido = 1;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreenUser()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                    child: const Center(
                      child: Text(
                        "reportar",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Monserrat",
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
              Container(
                width: 10.0,
              ),
            ],
          )
        ],
      ),
    );
  }

  GestureDetector item(String title, String icon) {
    return GestureDetector(
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: alert(title, icon),
          contentPadding: const EdgeInsets.all(10.0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          elevation: 48,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 20.0,
          ),
          SvgPicture.asset(
            icon,
            color: blue,
            height: 24,
          ),
          Container(
            width: 10.0,
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.black54, fontFamily: "Monserrat", fontSize: 16.0),
          )
        ],
      ),
    );
  }

  GestureDetector itemA(String title, String icon) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            color: blue,
            height: 24,
          ),
          Container(
            width: 10.0,
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.black54, fontFamily: "Monserrat", fontSize: 12.0),
          )
        ],
      ),
    );
  }

  Widget bottomNavBar(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyApp()));
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: color_icon_inicio,
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              shape: const CircleBorder(),
            ),
            child: SvgPicture.asset(
              "assets/images/inicio.svg",
              width: 40,
              color: Colors.white,
            ),
          ),
          Container(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const Pedidos()));
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: color_icon_historial,
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              shape: const CircleBorder(),
            ),
            child: SvgPicture.asset(
              "assets/images/historial2.svg",
              width: 40,
              color: Colors.white,
            ),
          ),
          Container(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AsistenciaTecnicaUsuario()));
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: color_icon_ingresos,
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              shape: const CircleBorder(),
            ),
            child: SvgPicture.asset(
              "assets/images/asistencia_tecnica.svg",
              width: 40,
              color: Colors.white,
            ),
          ),
          Container(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PerfilUsuario()));
              });
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: color_icon_perfil,
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
              shadowColor: Colors.grey,
              shape: const CircleBorder(),
            ),
            child: SvgPicture.asset(
              "assets/images/perfil.svg",
              width: 40,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
