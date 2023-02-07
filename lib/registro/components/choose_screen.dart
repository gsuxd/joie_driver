import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joiedriver/registro/bloc/registro_enums.dart';
import 'package:joiedriver/registro/components/resume_modal.dart';

import '../bloc/registro_bloc.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      //Hacemos un ListView en caso de que la pantalla tenga poco alto (como por ejemplo cuando el cel esta en horizontal)
      body: ListView(
        children: [
          BlocBuilder<RegistroBloc, RegistroState>(
            builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Logo
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: 100,
                  height: 100,
                  child: SvgPicture.asset("assets/icons/logo.svg"),
                ),
                //Bienvenido
                Container(
                  margin: const EdgeInsets.only(top: 32),
                  child: const Text(
                    "Bienvenido",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat Black",
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //Usuario o conductor (texto)
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 42),
                  child: const Text(
                    "¿Eres usuario o conductor?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat Black",
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _SelectType(
                    action: () {
                      if (state is ResumeRegistroState) {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (_) => const ResumeModal(
                                  userType: UserType.chofer,
                                ));
                        return;
                      }
                      context.read<RegistroBloc>().add(
                          InitializeRegistroEvent(UserType.chofer, context));
                    },
                    src: "assets/icons/conductor.svg",
                    text: "Conductor"),
                _SelectType(
                    action: () {
                      if (state is ResumeRegistroState) {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (_) => const ResumeModal(
                                  userType: UserType.pasajero,
                                ));
                        return;
                      }
                      context.read<RegistroBloc>().add(
                          InitializeRegistroEvent(UserType.pasajero, context));
                    },
                    src: "assets/icons/pasajero.svg",
                    text: "Usuario"),

                _SelectType(
                    action: () {
                      if (state is ResumeRegistroState) {
                        showModalBottomSheet(
                            isDismissible: false,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (_) => const ResumeModal(
                                  userType: UserType.emprendedor,
                                ));
                        return;
                      }
                      context.read<RegistroBloc>().add(InitializeRegistroEvent(
                          UserType.emprendedor, context));
                    },
                    src: "assets/icons/usuarios.svg",
                    text: "Emprendedor"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectType extends StatelessWidget {
  const _SelectType(
      {Key? key, required this.action, required this.src, required this.text})
      : super(key: key);
  final void Function() action;
  final String src;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Column(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: SvgPicture.asset(src),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25, bottom: 45),
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: "Montserrat black",
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
