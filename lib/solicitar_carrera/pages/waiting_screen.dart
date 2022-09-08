import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/blocs/carrera/carrera_bloc.dart';
import 'package:joiedriver/blocs/carrera/carrera_model.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  void _add(Oferta oferta) {
    setState(() {
      _ofertas.add(oferta);
    });
  }

  void _loadData(Carrera carrera) async {
    if (_initialized != true) {
      _initialized = true;
      final ref = FirebaseFirestore.instance
          .collection('carreras')
          .where('pasajeroId', isEqualTo: carrera.pasajeroId)
          .snapshots();
      await for (final val in ref) {
        if (val.docs.isEmpty) {
          continue;
        }
        for (var el in val.docs) {
          final _ = Carrera.fromJson(el.data());
          if (_.pasajeroId == carrera.pasajeroId && _.ofertas != _ofertas) {
            print('Carrera encontrada');
            _add(_.ofertas.last);
          }
        }
      }
    }
  }

  final List<Oferta> _ofertas = [];
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<CarreraBloc, CarreraState>(
      builder: (context, state) {
        if (state is CarreraEnEspera) {
          _loadData(state.carrera);
          return ListView.builder(
            itemCount: _ofertas.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_ofertas[index].chofer),
                subtitle: Text(_ofertas[index].precio.toString()),
              );
            },
          );
        }
        if (state is CarreraEnCurso) {
          return const Text("en curso");
        }
        return const Center(child: Text("State error, please try again"));
      },
    ));
  }
}
