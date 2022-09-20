import 'package:flutter/material.dart';
import '../../../colors.dart';
import '../../../mensaje.dart';
import '../../../mensaje_dao.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import '../../../mensajewidget.dart';

class ListaMensajesEmprendedor extends StatefulWidget {
  final mensajeDAO = MensajeDAO();
  final String id_chat;
  final String usuario;

  ListaMensajesEmprendedor(this.id_chat, this.usuario);

  @override
  ListaMensajesState createState() => ListaMensajesState(id_chat, usuario);
}

class ListaMensajesState extends State<ListaMensajesEmprendedor> {
  final String id_chat;
  final String usuario;

  ListaMensajesState(this.id_chat, this.usuario);

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _mensajeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollHaciaAbajo());

    return Scaffold(
        appBar: AppBar(

          title: const Text(
            'Chat',
          ),
          backgroundColor: blue,
          leading:  ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: blue,
              elevation: 0
            ),
            onPressed: () {
              Navigator.pop(context);
              },
            child: const Icon(Icons.arrow_back_ios, size: 30,),
          ),

        ),
        body: Padding(
            padding: const EdgeInsets.only(
                top: 0.0, bottom: 10.0, left: 5.0, right: 5.0),
            child: Column(children: [
              _getListaMensajes(),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Flexible(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          onChanged: (text){
                            setState(() {

                            });
                          },
                            minLines: 1,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            controller: _mensajeController,
                            decoration: const InputDecoration(
                                hintText: 'Escribe un mensaje')))),
                IconButton(
                  padding: const EdgeInsets.all(0.0),
                    icon: Icon(_puedoEnviarMensaje()
                        ? Icons.play_arrow_rounded
                        : Icons.play_arrow_outlined,
                    size: 48,
                    color: blue,),
                    onPressed: () {
                      _enviarMensaje();
                    })
              ]),
            ])));
  }

  void _enviarMensaje() {
    if (_puedoEnviarMensaje()) {
      final mensaje = Mensaje(_mensajeController.text, DateTime.now(), usuario);
      MensajeDAO.guardarMensajeEmprendedor(mensaje, usuario, id_chat);
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
          query: widget.mensajeDAO.getMensajesEmprendedor(usuario, id_chat),
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
