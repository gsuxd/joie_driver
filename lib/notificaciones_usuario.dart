import 'package:joiedriver/pedidos.dart';
import 'package:joiedriver/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'colors.dart';
import 'estatics.dart';
import 'notificacion_usuario.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'notificaciones_usuario_dao.dart';
import 'notificacionwidget.dart';

class ListaNotificacionesUsuario extends StatefulWidget {
  const ListaNotificacionesUsuario({Key? key}) : super(key: key);
  final notificacionDAO = const NotificacionUsuarioDAO();

  @override
  ListaNotificacionesUsuarioState createState() =>
      ListaNotificacionesUsuarioState();
}

class ListaNotificacionesUsuarioState
    extends State<ListaNotificacionesUsuario> {
  String usuario = "UsuarioPrueba";
  final ScrollController _scrollController = ScrollController();
  Color color_icon_inicio = blue;
  Color color_icon_historial = blue;
  Color color_icon_perfil = blue;
  Color color_icon_ingresos = blue;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollHaciaAbajo());

    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.notifications,
            color: Colors.white,
            size: 30,
          ),
          title: const Text(
            'Notificaciones',
          ),
          backgroundColor: blue,
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 0.0, right: 0.0),
            child: Column(children: [
              _getListaMensajes(),
              bottomNavBar(context),
            ])));
  }

  Widget _getListaMensajes() {
    return Expanded(
        flex: 1,
        child: FirebaseAnimatedList(
          shrinkWrap: true,
          controller: _scrollController,
          query: widget.notificacionDAO.getMensajes(usuario),
          itemBuilder: (context, snapshot, animation, index) {
            final json = snapshot.value as Map<dynamic, dynamic>;
            final mensaje = Notificacion.fromJson(json);
            return NotificacionWidget(
                snapshot.key.toString(), mensaje.fecha, "UsuarioPrueba");
          },
        ));
  }

  void _scrollHaciaAbajo() {
    if (_scrollController.hasClients) {
      //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  Widget bottomNavBar(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {},
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Pedidos()));
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Statics()));
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Profile()));
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
