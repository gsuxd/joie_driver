import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';

class VerificacionPage extends StatelessWidget {
  const VerificacionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const Text('Verificacion'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          Text(
            'Antes de comenzar necesitas verificarte',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 80,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ElevatedButton(
              onPressed: () async {
                context
                    .read<UserBloc>()
                    .add(VerifyUserEvent(VerifyType.shareLink, context));
              },
              child: const Text('Compartir enlace'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Subir comprobante de pago'),
            ),
          ])
        ]),
      ),
    );
  }
}
