import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'colors.dart';

class MensajeWidget extends StatelessWidget {
  final String texto;
  final DateTime fecha;
  final String usuario;

  MensajeWidget(this.texto, this.fecha, this.usuario);

  Color caja = blue;
  CrossAxisAlignment alineacion = CrossAxisAlignment.end;

  @override
  Widget build(BuildContext context) {
    if (usuario != "UsuarioPrueba") {
      caja = Colors.blueGrey;
      alineacion = CrossAxisAlignment.start;
      return sms2();
    } else {
      caja = blue;
      alineacion = CrossAxisAlignment.end;
      return sms();
    }
  }

  Column sms() {
    return Column(
      crossAxisAlignment: alineacion,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 40.0, top: 5, right: 1.0, bottom: 2),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[350]!,
                        blurRadius: 2.0,
                        offset: const Offset(0, 1.0))
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                  color: caja,
                ),
                child: MaterialButton(
                  disabledTextColor: Colors.black87,
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  onPressed: null,
                  child: Text(
                    texto,
                    textAlign: TextAlign.start,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                        DateFormat('kk:mma, dd-MM-yyyy')
                            .format(fecha)
                            .toString(),
                        style: const TextStyle(color: Colors.grey))))
          ]),
        ),
      ],
    );
  }

  Column sms2() {
    return Column(
      crossAxisAlignment: alineacion,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 1.0, top: 5, right: 40.0, bottom: 2),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[350]!,
                        blurRadius: 2.0,
                        offset: const Offset(0, 1.0))
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                  color: caja,
                ),
                child: MaterialButton(
                    disabledTextColor: Colors.black87,
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                    onPressed: null,
                    child: Wrap(
                      children: <Widget>[
                        Text(
                          texto,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ))),
            Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                        DateFormat('kk:mm a, dd-MM-yyyy')
                            .format(fecha)
                            .toString(),
                        style: const TextStyle(color: Colors.grey))))
          ]),
        ),
      ],
    );
  }
}
