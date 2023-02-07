import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/conts.dart';
import 'package:joiedriver/registro/bloc/registro_enums.dart';

import '../bloc/registro_bloc.dart';

class ResumeModal extends StatelessWidget {
  const ResumeModal({Key? key, required this.userType}) : super(key: key);
  final UserType userType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: blue, width: 5),
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20), bottom: Radius.zero)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Espera!",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Colors.black)),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Se ha detectado que recientemente ha intentado registrarse, desea reanudar?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          context
                              .read<RegistroBloc>()
                              .add(ResumeRegistroEvent(context));
                        },
                        icon: const Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        label: const Text('Continuar'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          context
                              .read<RegistroBloc>()
                              .add(InitializeRegistroEvent(userType, context));
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                        ),
                        label: const Text('Cancelar'),
                      ),
                    ])),
          ],
        ),
      ),
    );
  }
}
