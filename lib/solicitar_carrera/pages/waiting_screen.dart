import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/blocs/carrera/carrera_bloc.dart';
import 'package:joiedriver/blocs/carrera/carrera_model.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key, required this.carreraRef}) : super(key: key);
  final DocumentReference<Map<String, dynamic>> carreraRef;

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  void _add(Oferta oferta) {
    setState(() {
      _ofertas.add(oferta);
    });
  }

  void _handleSnapshot(val) {
    if (val.data() != null) {
      final _ = Carrera.fromJson(val.data());
      if (_.ofertas != _ofertas && _.ofertas.isNotEmpty) {
        print('Carrera encontrada');
        _add(_.ofertas.last);
      }
    }
  }

  void _loadData(Carrera carrera) async {
    if (_initialized != true) {
      _initialized = true;
      widget.carreraRef.snapshots().listen(_handleSnapshot);
    }
  }

  final List<Oferta> _ofertas = [];
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Waiting'),
        ),
        body: BlocBuilder<CarreraBloc, CarreraState>(
          builder: (context, state) {
            if (state is CarreraEnEspera) {
              _loadData(state.carrera);
              return Column(
                children: [
                  const Text('Carrera en espera'),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _ofertas.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_ofertas[index].chofer),
                        subtitle: Text(_ofertas[index].precio.toString()),
                        onTap: () {
                          context.read<CarreraBloc>().add(AceptarOfertaEvent(
                              widget.carreraRef,
                              _ofertas[index].choferId,
                              context));
                        },
                      );
                    },
                  )
                ],
              );
            }
            if (state is CarreraEnCurso) {
              return const Text("en curso");
            }
            if (state is CarreraLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const Center(child: Text("State error, please try again"));
          },
        ));
  }
}
