import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joiedriver/conts.dart';
import 'package:joiedriver/metodos_pago/components/nuevo_metodo.dart';
import '../bloc/metodos_pago_bloc.dart';

// ignore: must_be_immutable
class BanksDropdown extends StatefulWidget {
  const BanksDropdown({Key? key}) : super(key: key);

  @override
  State<BanksDropdown> createState() => _BanksDropdownState();
}

class _BanksDropdownState extends State<BanksDropdown> {
  // ignore: prefer_final_fields
  Color _color = Colors.grey;
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
            items: banco.map((String bancos) {
              return DropdownMenuItem(
                  value: bancos,
                  child: Row(children: [
                    SvgPicture.asset(
                      bancos,
                      height: 20,
                    )
                  ]));
            }).toList(),
            focusNode: _focusNode,
            underline: Container(
              height: 0,
            ),
            icon: const Icon(Icons.money_sharp),
            elevation: 16,
            style: const TextStyle(color: Colors.black, fontSize: 17),
            onChanged: (value) {
              setState(() {
                String name = "Banco";
                switch (value) {
                  case bancolombia:
                    name = "Bancolombia";
                    break;
                  case bbva:
                    name = "BBVA";
                    break;
                  case bogotaBank:
                    name = "Banco de Bogotá";
                    break;
                  case colpatria:
                    name = "Colpatria";
                    break;
                  case davivienda:
                    name = "Davivienda";
                    break;
                  case avvillas:
                    name = "Banco Av Villas";
                    break;
                  case bancamia:
                    name = "Bancamia";
                    break;
                  case bancoAgrario:
                    name = "Banco Agrario";
                    break;
                  case bancoCajaSocial:
                    name = "Banco Caja Social";
                    break;
                  case bancoCoopCentral:
                    name = "Banco Cooperativo Coopcentral";
                    break;
                  case credifinanciera:
                    name = "Banco Credifinaciera";
                    break;
                  case bancodeOccidente:
                    name = "Banco de Occidente";
                    break;
                  case falabella:
                    name = "Banco Falabella";
                    break;
                  case finandia:
                    name = "Banco Finandina";
                    break;
                  case itau:
                    name = "Banco Itaú";
                    break;
                  case pichincha:
                    name = "Banco Pichincha";
                    break;
                  case bpc:
                    name = "Banco Popular de Colombia";
                    break;
                  case bancoW:
                    name = "BancoW";
                    break;
                  case bancoOmeva:
                    name = "Bancoomeva";
                    break;
                  case bancoldex:
                    name = "Bancoldex";
                    break;
                }
                vistaCuenta = name;
                bank = name;
              });
            },
            hint: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bank.isEmpty ? vistaCuenta : bank,
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
            focusColor: jBase,
            alignment: Alignment.centerRight,
          );
        },
      ),
    );
  }
}
