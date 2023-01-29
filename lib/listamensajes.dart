import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'colors.dart';
import 'mensaje.dart';
import 'mensaje_dao.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'mensajewidget.dart';

class ListaMensajes extends StatefulWidget {
  final mensajeDAO = const MensajeDAO();
  final String id_chat;
  final String usuario;
  const ListaMensajes(this.id_chat, this.usuario, {Key? key}) : super(key: key);
  @override
  ListaMensajesState createState() => ListaMensajesState();
}

class ListaMensajesState extends State<ListaMensajes> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _mensajeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollHaciaAbajo());

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Chat',
          ),
          backgroundColor: blue,
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 5.0, right: 5.0),
            child: Column(children: [
              _getListaMensajes(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Flexible(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                            minLines: 1,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            controller: _mensajeController,
                            decoration: const InputDecoration(
                                hintText: 'Escribe un mensaje')))),
                IconButton(
                    icon: Icon(_puedoEnviarMensaje()
                        ? CupertinoIcons.arrow_right_circle_fill
                        : CupertinoIcons.arrow_right_circle),
                    onPressed: () {
                      _enviarMensaje();
                    })
              ]),
            ])));
  }

  void _enviarMensaje() {
    if (_puedoEnviarMensaje()) {
      final mensaje =
          Mensaje(_mensajeController.text, DateTime.now(), widget.usuario);
      MensajeDAO.guardarMensaje(mensaje, widget.usuario, widget.id_chat);
      _mensajeController.clear();
      setState(() {});
    }
  }

  bool _puedoEnviarMensaje() => _mensajeController.text.isNotEmpty;

  Widget _getListaMensajes() {
    return Expanded(
        flex: 1,
        child: FirebaseAnimatedList(
          //shrinkWrap: true,
          controller: _scrollController,
          query: widget.mensajeDAO.getMensajes(widget.usuario, widget.id_chat),
          itemBuilder: (context, snapshot, animation, index) {
            final json = snapshot.value as Map<dynamic, dynamic>;
            final mensaje = Mensaje.fromJson(json);
            return MensajeWidget(
                mensaje.mensaje, mensaje.fecha, mensaje.usuario);
          },
        ));
  }

  void _scrollHaciaAbajo() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}
