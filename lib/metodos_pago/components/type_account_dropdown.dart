import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/metodos_pago/components/nuevo_metodo.dart';

import '../bloc/metodos_pago_bloc.dart';

// ignore: must_be_immutable
class TypeAccountDropdown extends StatefulWidget {
  const TypeAccountDropdown({Key? key}) : super(key: key);

  @override
  State<TypeAccountDropdown> createState() => _TypeAccountDropdownState();
}

class _TypeAccountDropdownState extends State<TypeAccountDropdown> {
  // ignore: prefer_final_fields
  Color _color = Colors.grey;
  // ignore: prefer_final_fields
  String _view = 'Tipo de cuenta';
  final FocusNode _focusNode = FocusNode();

  void _focusListener() {
    if (_focusNode.hasFocus) {
      setState(() {
        _color = Colors.blue;
      });
    } else {
      setState(() {
        _color = Colors.grey;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusListener);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: _color,
          width: 1,
        ),
      )),
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
      child: BlocBuilder<MetodoPagoBloc, MetodoPagoState>(
        bloc: metodosPagoBloc,
        builder: (context, state) {
          return DropdownButton<String>(
            focusNode: _focusNode,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black, fontSize: 17),
            onChanged: (newValue) {
              setState(
                () {
                  typeAccount = newValue as String;
                },
              );
            },
            underline: Container(
              height: 0,
            ),
            hint: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    typeAccount.isEmpty ? _view : typeAccount,
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
            items: ['Cuenta corriente', 'Cuenta de ahorro'].map(
              (value) {
                return DropdownMenuItem(
                  value: value,
                  child: Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: Text(value)),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
