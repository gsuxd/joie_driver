import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/registro/bloc/registro_bloc.dart';
import 'package:joiedriver/sign_in/log_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "loading";
  }
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    context.read<RegistroBloc>().add(EnviarRegistroEvent(
        context, (context.read<RegistroBloc>().state as dynamic).userData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrando'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<RegistroBloc, RegistroState>(
              builder: (context, state) {
                if (state is LoadingRegistroState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 24,
                );
              },
            ),
            BlocBuilder<RegistroBloc, RegistroState>(
              builder: (context, state) {
                if (state is! UpdateRegistroState) {
                  return Center(
                    child: Text(
                        context.select((RegistroBloc bloc) =>
                            (bloc.state as dynamic).message),
                        textAlign: TextAlign.center),
                  );
                }
                return const SizedBox();
              },
            ),
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
      ),
    );
  }
}
