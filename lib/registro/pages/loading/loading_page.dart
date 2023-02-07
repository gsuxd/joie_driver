import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/registro/bloc/registro_bloc.dart';
import 'package:joiedriver/sign_in/log_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "loading";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrando'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<RegistroBloc, RegistroState>(
            builder: (context, state) {
              if (state is LoadingRegistroState) {
                return const CircularProgressIndicator();
              }
              return const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 24,
              );
            },
          ),
          Text(context
              .select((RegistroBloc bloc) => (bloc.state as dynamic).message)),
          BlocBuilder<RegistroBloc, RegistroState>(builder: (context, state) {
            if (state is ErrorRegistroState) {
              return ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (_) => const LognInScreenUser()),
                        (route) => false);
                  },
                  child: const Text("Volver al inicio"));
            }
            return const SizedBox();
          })
        ],
      ),
    );
  }
}
