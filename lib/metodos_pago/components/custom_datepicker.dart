import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/metodos_pago/components/nuevo_metodo.dart';

import '../bloc/metodos_pago_bloc.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({Key? key}) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  String date = "";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // showDatePicker(
        //   context: context,
        //   initialDate: DateTime.now(),
        //   firstDate: DateTime(1900),
        //   lastDate: DateTime(
        //       DateTime.now().year, DateTime.now().month, DateTime.now().day),
        // ).then((value) {
        //   if (value != null) {
        //     setState(() {
        //       date = value.toString().substring(0, 10);
        //       dateCI = value.toString().substring(0, 10);
        //     });
        //   }
        // });
      },
      child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BlocBuilder<MetodoPagoBloc, MetodoPagoState>(
                bloc: metodosPagoBloc,
                builder: (context, state) {
                  return Text(
                    dateCI.isEmpty
                        ? 'Fecha de emisión de la cedula'
                        : dateCI.substring(0, 10),
                    style: const TextStyle(fontSize: 17, color: Colors.black54),
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: Colors.grey,
                ),
              ),
            ],
          )),
    );
  }
}
