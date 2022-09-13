import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import "package:flutter/material.dart";
import '../../../notificacion_usuario.dart';
import '../../../notificaciones_usuario_dao.dart';
import '../../../notificacionwidget.dart';
import '../../../register_login_emprendedor/conts.dart';
import '../appbar.dart';


//Creamos la clase AsisTec
class ListAsisTecnicaEmprendedor extends StatefulWidget {
  static String routeName = '/support';

  const ListAsisTecnicaEmprendedor({Key? key}) : super(key: key);
  @override
  createState() => _List();
}

class _List extends State<ListAsisTecnicaEmprendedor> {

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    getData();

  }

  Future getData() async {
    email = await encryptedSharedPreferences.getString('email');
    email = email.substring(0, email.length-4);
    return true;
  }
  final ScrollController _scrollController = ScrollController();
  String email = "None";
  EncryptedSharedPreferences encryptedSharedPreferences =
  EncryptedSharedPreferences();
  final notificacionDAO = NotificacionUsuarioDAO();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollHaciaAbajo());
    return Scaffold(
      appBar: appBarEmprendedor(
          accion: [], leading: back(context), title: 'Solicitudes'),
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 10.0, left: 0.0, right: 0.0),
          child: Column(children: [
            _getListaMensajes(),
          ])),
    );
  }

  void _scrollHaciaAbajo() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

   _getListaMensajes()  {
    return Expanded(
        flex: 1,
        child: FirebaseAnimatedList(
          shrinkWrap: true,
          controller: _scrollController,
          query: notificacionDAO.getMensajesEmprendedor(email),
          itemBuilder: (context, snapshot, animation, index) {
            final json = snapshot.value as Map<dynamic, dynamic>;
            final mensaje = Notificacion.fromJson(json);
            return NotificacionWidget(
                snapshot.key.toString(), mensaje.fecha, email);
          },
        ));
  }
}
