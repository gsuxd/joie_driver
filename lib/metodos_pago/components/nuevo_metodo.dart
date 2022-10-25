import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/metodos_pago/bloc/metodos_pago_bloc.dart';
import 'package:joiedriver/metodos_pago/components/custom_datepicker.dart';
import 'package:joiedriver/metodos_pago/components/custom_dropdown.dart';
import 'package:joiedriver/metodos_pago/components/custom_input.dart';
import 'package:joiedriver/metodos_pago/components/type_account_dropdown.dart';
import 'package:joiedriver/metodos_pago/models/metodo_pago.dart';

String bank = '';
String typeAccount = "";
String dateCI = "";

// ignore: must_be_immutable
class NuevoMetodo extends StatefulWidget {
  const NuevoMetodo({Key? key}) : super(key: key);

  @override
  State<NuevoMetodo> createState() => _NuevoMetodoState();
}

final metodosPagoBloc = MetodoPagoBloc();

class _NuevoMetodoState extends State<NuevoMetodo> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _numberCIController = TextEditingController();

  final TextEditingController _numberBankController = TextEditingController();

  @override
  void initState() {
    super.initState();
    metodosPagoBloc.add(LoadMetodoPagoEvent());
  }

  // ignore: prefer_final_fields
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
          textScaleFactor:
              MediaQuery.of(context).textScaleFactor.clamp(0.8, 2.3)),
      child: BlocListener<MetodoPagoBloc, MetodoPagoState>(
        bloc: metodosPagoBloc,
        listener: (context, state) {
          if (state is MetodoPagoLoaded) {
            _nameController.text = state.metodoPago.nameComplete;
            _numberCIController.text = state.metodoPago.numberCI;
            _numberBankController.text = state.metodoPago.numberBank;
            bank = state.metodoPago.bank;
            typeAccount = state.metodoPago.typeBank;
            dateCI = state.metodoPago.dateCI;
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Editar metodo de pago',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              backgroundColor: Colors.blue,
              elevation: 4,
            ),
            body: BlocBuilder<MetodoPagoBloc, MetodoPagoState>(
              bloc: metodosPagoBloc,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(24).copyWith(top: 15),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        child: const Center(
                          child: Text(
                            'Ingrese los datos de una cuenta bancaria de su propiedad',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      CustomTextField(
                        maxLength: 50,
                        disabled: true,
                        controller: _nameController,
                        icon: Icons.account_balance,
                        placeHolder: 'Nombre completo',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio';
                          }
                          return null;
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.transparent,
                      ),
                      CustomTextField(
                        disabled: true,
                        maxLength: 15,
                        controller: _numberCIController,
                        icon: Icons.credit_card,
                        placeHolder: 'Cedula de identidad',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio';
                          }
                          if (value.length != 10) {
                            return 'La cedula de identidad debe tener 10 digitos';
                          }
                          return null;
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.transparent,
                      ),
                      const CustomDatePicker(),
                      const Divider(
                        thickness: 1,
                        color: Colors.transparent,
                      ),
                      const BanksDropdown(),
                      const Divider(
                        thickness: 1,
                        color: Colors.transparent,
                      ),
                      CustomTextField(
                        disabled: false,
                        maxLength: 20,
                        controller: _numberBankController,
                        icon: Icons.credit_card,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio';
                          }
                          if (value.length != 20) {
                            return 'El numero de cuenta debe tener 20 digitos';
                          }
                          return null;
                        },
                        placeHolder: 'Numero de cuenta del banco',
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.transparent,
                      ),
                      const TypeAccountDropdown(),
                      const Divider(
                        thickness: 3,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            if (state is MetodoPagoLoading) {
                              return;
                            }
                            final data = {
                              'nameComplete': _nameController.text,
                              'number_ci': _numberCIController.text,
                              'date_ci': dateCI,
                              'bank': bank,
                              'number_bank': _numberBankController.text,
                              'type_bank': typeAccount,
                            };

                            for (var element in data.keys) {
                              if (data[element] == '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.blue,
                                    content: Text(
                                        'Faltan datos por favor verifique'),
                                  ),
                                );
                                break;
                              }
                            }
                            metodosPagoBloc.add(
                                AddMetodoPagoEvent(MetodoPago.fromJson(data)));
                          },
                          child: state is MetodoPagoLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text('Añadir metodo de pago'),
                        ),
                      )
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
