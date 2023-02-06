import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/registro/bloc/registro_bloc.dart';

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
              .select((RegistroBloc bloc) => (bloc.state as dynamic).message))
        ],
      ),
    );
  }
}
