import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joiedriver/blocs/carrera/carrera_bloc.dart';
import 'package:joiedriver/blocs/carrera/carrera_model.dart';

enum FormasPago {
  efectivo,
  bancolombia,
  davivienda,
  colpatria,
  bbva,
  bancoDeBogota,
  nequi
}

class SelectPagoScreen extends StatefulWidget {
  const SelectPagoScreen({Key? key, required this.data}) : super(key: key);

  final Map data;

  @override
  State<SelectPagoScreen> createState() => _SelectPagoScreenState();
}

class _SelectPagoScreenState extends State<SelectPagoScreen> {
  FormasPago _formaPago = FormasPago.efectivo;

  static const TextStyle _style = TextStyle(
    color: Colors.black,
    fontFamily: "Monserrat",
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 65),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            const Expanded(
              child: Text(
                "Forma de pago",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Monserrat",
                ),
              ),
            )
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Cómo quieres pagar tu carrera?",
                style: _style,
              ),
              ListTile(
                title: Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 10),
                        child:
                            Image.asset("assets/images/cash.png", width: 30)),
                    const Text('Efectivo', style: _style),
                  ],
                ),
                leading: Radio(
                  value: FormasPago.efectivo,
                  groupValue: _formaPago,
                  onChanged: (value) {
                    setState(() {
                      _formaPago = value as FormasPago;
                    });
                  },
                ),
              ),
              const Text(
                "Transferencia de:",
                style: _style,
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/bancolombia.svg',
                      width: 110,
                    ),
                  ],
                ),
                leading: Radio(
                  value: FormasPago.bancolombia,
                  groupValue: _formaPago,
                  onChanged: (value) {
                    setState(() {
                      _formaPago = value as FormasPago;
                    });
                  },
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/Davivienda.svg',
                      width: 110,
                    ),
                  ],
                ),
                leading: Radio(
                  value: FormasPago.davivienda,
                  groupValue: _formaPago,
                  onChanged: (value) {
                    setState(() {
                      _formaPago = value as FormasPago;
                    });
                  },
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/bogotabank.svg',
                      width: 110,
                    ),
                  ],
                ),
                leading: Radio(
                  value: FormasPago.bancoDeBogota,
                  groupValue: _formaPago,
                  onChanged: (value) {
                    setState(() {
                      _formaPago = value as FormasPago;
                    });
                  },
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/bbva.svg',
                      width: 110,
                    ),
                  ],
                ),
                leading: Radio(
                  value: FormasPago.bbva,
                  groupValue: _formaPago,
                  onChanged: (value) {
                    setState(() {
                      _formaPago = value as FormasPago;
                    });
                  },
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/nequi.svg',
                      width: 110,
                    ),
                  ],
                ),
                leading: Radio(
                  value: FormasPago.nequi,
                  groupValue: _formaPago,
                  onChanged: (value) {
                    setState(() {
                      _formaPago = value as FormasPago;
                    });
                  },
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/colpatria.svg',
                      width: 110,
                    ),
                  ],
                ),
                leading: Radio(
                  value: FormasPago.colpatria,
                  groupValue: _formaPago,
                  onChanged: (value) {
                    setState(() {
                      _formaPago = value as FormasPago;
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 180),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        final Carrera carrera = Carrera(
                          aceptada: false,
                          condicionEspecial: widget.data['necesidad'],
                          destino: widget.data['destino'],
                          inicio: widget.data['inicio'],
                          metodoPago: _formaPago.name,
                          numeroPasajeros: widget.data['pasajeros'],
                          pasajeroId: widget.data['pasajeroId'],
                          precioOfertado: widget.data['montoOferta'],
                        );
                        context
                            .read<CarreraBloc>()
                            .add(NuevaCarreraEvent(carrera));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: const Text(
                          "Siguiente",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontFamily: "Monserrat",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
