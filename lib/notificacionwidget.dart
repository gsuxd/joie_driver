import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:joiedriver/register_login_emprendedor/app_screens/asistencia_tecnica/listamensajesemprendedor.dart';
import 'colors.dart';

class NotificacionWidget extends StatelessWidget {
  final String id_chat;
  final DateTime fecha;
  final String usuario;

  NotificacionWidget(this.id_chat,this.fecha, this.usuario, {Key? key}) : super(key: key);
  Color caja = blue;

  @override
  Widget build(BuildContext context) {
      return sms(context);
  }

  Widget sms(BuildContext context) {
    return Column(
       children: [
         Padding(
           padding: const EdgeInsets.only(left: 5.0, right: 5.0),
         child: Column(
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Row(
                   children: [
                     SvgPicture.asset(
                       "assets/images/asistencia_tecnica.svg",
                       width: 16,
                       color: Colors.blue,
                     ),
                     const Text("Asistencia Tecnica", style: TextStyle(color: blue, fontFamily: "Monserrat", ),),
                   ],
                 ),
                 Text(DateFormat('kk:mm  dd/MM/yyyy').format(fecha).toString(), style: const TextStyle(color: Colors.grey, fontFamily: "Monserrat", ),),
                 GestureDetector(
                   onTap: (){},
                   child: const Icon(Icons.cancel_sharp, color: Colors.red,),
                 ),
               ],),
             Row(
               children: const [
                 Text("Reporte en tramite", style: TextStyle(color: Colors.black87, fontFamily: "Monserrat", ),)
               ],),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 const Text("Hemos revisado su reporte", style: TextStyle(color: Colors.black54, fontFamily: "Monserrat", ),),
                 GestureDetector(
                   onTap: (){
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) => ListaMensajesEmprendedor( id_chat, usuario)));
                   },
                   child:const Text("Ver", style: TextStyle(color: blue, fontFamily: "Monserrat", ),),
                 ),
               ],),
           ],
         ),),

         const Divider(
           thickness: 2,
           height: 10,
           color: Colors.black87,
         )
       ],
    );
  }

}