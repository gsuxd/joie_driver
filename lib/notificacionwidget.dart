
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'colors.dart';
import 'listamensajes.dart';

class NotificacionWidget extends StatelessWidget {
  final String id_chat;
  final DateTime fecha;
  final String usuario;

  NotificacionWidget(this.id_chat,this.fecha, this.usuario);
  Color caja = blue;

  @override
  Widget build(BuildContext context) {
      return sms(context);
  }

  Widget sms(BuildContext context) {
    return Row(
        children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Row(
                       children: [
                         Container(width: 5,),
                         SvgPicture.asset(
                           "assets/images/asistencia_tecnica.svg",
                           width: 16,
                           color: Colors.blue,
                         ),
                         Text("Asistencia Tecnica", style: TextStyle(color: blue, fontFamily: "Monserrat", ),)
                       ],
                     ),
                      Container(width: MediaQuery.of(context).size.width - 310,),
                      Row(
                        children: [
                          Text(DateFormat('kk:mm  dd/MM/yyyy').format(fecha).toString(), style: TextStyle(color: Colors.grey, fontFamily: "Monserrat", ),),
                          Container(width: 5,),
                          GestureDetector(
                            onTap: (){},
                            child: Icon(Icons.cancel_sharp, color: Colors.red,),
                          ),
                          Container(width: 5,),
                        ],
                      ),
                      

                    ],
                  ),

                  Row(
                    children: [
                      Container(width: 15,),

                      Text("Reporte en tramite", style: TextStyle(color: Colors.black87, fontFamily: "Monserrat", ),)
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(width: 15,),

                          Text("Hemos revisado su reporte", style: TextStyle(color: Colors.black54, fontFamily: "Monserrat", ),)
                        ],
                      ),
                      Container(width: MediaQuery.of(context).size.width - 240,),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListaMensajes( id_chat, usuario)));
                            },
                            child:Text("Ver", style: TextStyle(color: blue, fontFamily: "Monserrat", ),),
                          ),
                          Container(width: 5,),

                        ],
                      ),

                      ],
                  ),

                  Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black87,
                    margin: EdgeInsets.only(top: 5, bottom: 5.0),
                  )
                ]
            ),
        ],
      );
  }

}