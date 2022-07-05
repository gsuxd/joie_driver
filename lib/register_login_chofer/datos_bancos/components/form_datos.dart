import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joiedriver/components/default_button_chofer.dart';
import '../../../components/error_form.dart';
import '../../../register_login_chofer/size_config.dart';
import '../../conts.dart';


class BancoForm extends StatefulWidget {
  const BancoForm({Key? key}) : super(key: key);

  @override
  State<BancoForm> createState() => _BancoFormState();
}

class _BancoFormState extends State<BancoForm> {
  final List<String> errors = [];
  String? tipoCuenta2;
  String? bancoChofer;
  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        nombreCompletoFormField(),
        spaceMedium(),
        cedulaFormField(),
        spaceMedium(),
        dateCedulaFormField(),
        spaceMedium(),
        bancoSelectField(),
        spaceMedium(),
        cuentaFormField(),
        spaceMedium(),
        tipoCuentaSelect(),
        spaceMedium(),
        FormError(errors: errors),
        spaceMedium(),
        ButtonDefChofer(text: 'Siguiente', press: (){},)
      ],
    );
  }

  SizedBox spaceMedium() {
    return SizedBox(
      height: getPropertieScreenHeight(30),
    );
  }

  TextFormField nombreCompletoFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: controllerTextName,
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(nameNull)) {
          removeError(error: nameNull);
          return;
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(nameNull)) {
          addError(error: nameNull);
          return "";
        }

        return null;
      },
      keyboardType: TextInputType.name,
      autocorrect: true,
      decoration: InputDecoration(
          hintText: "Ingresa tu Nombre Completo",
          labelText: "Nombre Completo",
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
            ),
            child: Icon(
              Icons.account_circle_outlined,
              size: getPropertieScreenWidth(18),
            ),
          )),
    );
  }

  TextFormField cedulaFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: controllerTextCedula,
      onSaved: (newValue) => cedula = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(cedulaError)) {
          removeError(error: cedulaError);
          setState(() {});
          return;
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(cedulaNull)) {
          addError(error: cedulaNull);
          return;
        }

        if (value.length < 10 && !errors.contains(cedulaError)) {
          addError(error: cedulaError);
          return;
        }

        return null;
      },
      autocorrect: true,
      keyboardType: TextInputType.number,
      maxLength: 10,
      decoration: InputDecoration(
          hintText: "Ingresa su número de Cédula",
          labelText: "Cédula",
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
            ),
            child: SvgPicture.asset(cedulaIcon,
                width: getPropertieScreenWidth(18)),
          )),
    );
  }

  TextFormField cuentaFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: controllerTextNumber,
      onSaved: (newValue) => numberAccount = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(cedulaError)) {
          removeError(error: cedulaError);
          setState(() {});
          return;
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(cedulaNull)) {
          addError(error: cedulaNull);
          return;
        }

        if (value.length < 16 && !errors.contains(cedulaError)) {
          addError(error: cedulaError);
          return;
        }

        return null;
      },
      autocorrect: true,
      keyboardType: TextInputType.number,
      maxLength: 20,
      decoration: InputDecoration(
          hintText: "Ingresa su número de cuenta",
          labelText: "Cuenta Bancaria",
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
            ),
            child: SvgPicture.asset(cedulaIcon,
                width: getPropertieScreenWidth(18)),
          )),
    );
  }

  DateTimeFormField dateCedulaFormField() {
    return DateTimeFormField(
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: const EdgeInsets.all(13),
          child: Container(
            margin: const EdgeInsets.only(right: 1),
            width: 2,
            height: 2,
            child: SvgPicture.asset(
              cedulaIcon,
              width: 0.5,
              fit: BoxFit.fitWidth,
              color: Colors.grey,
            ),
          ),
        ),
        labelText: 'Fecha de emisión de la cédula',
        hintText: 'Ingrese la fecha de emisión de la cédula',
      ),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,
      firstDate: DateTime(1942, 01, 01),
      lastDate: DateTime.now(),
      initialDate: DateTime(1984, 01, 01),
      // validator: (e) =>
      // (e?.day ?? 0) == 1 ? 'Por favor ingrese la fecha correcta' : null,
      validator: (date) {
        var diferencia = date?.difference(DateTime.now());

        if (diferencia?.inDays.toInt() != null) {
          if (diferencia!.inDays.toInt().abs() < 6573) {
            return 'Debes ser mayor de edad para trabajar con nosotros';
          }
        }
        return null;
      },
      onDateSelected: (DateTime value) {
        controllerTextDate = value.toString();
      },
    );
  }

  Container bancoSelectField() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          //border: Border.all(color: jBase),
          //borderRadius: BorderRadius.circular(40),
          ),
      child: DropdownButton(
        items: banco.map((String bancos) {
          return DropdownMenuItem(
              value: bancos, child: Row(children: [SvgPicture.asset(bancos, height: 20,)]));
        }).toList(),
        onChanged: (value) {
          setState(() {
            String name = "Selecciona tu Banco";
            if(value == "assets/images/nequi.svg"){
              name = "NEQUI";
            }else if(value == "assets/images/bancolombia.svg"){
              name = "Bancolombia";
            }else if(value == "assets/images/bbva.svg"){
              name = "BBVA";
            }else if(value == "assets/images/bogotabank.svg"){
              name = "Banco de Bogotá";
            }else if(value == "assets/images/colpatria.svg"){
              name = "ColPatria";
            }else if(value == "assets/images/Davivienda.svg"){
              name = "Davivienda";
            }
            vistaCuenta = name;
            bancoChofer = name;
          });
        },
        hint: SizedBox(
          width: MediaQuery.of(context).size.width - 54,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(vistaCuenta),
            SvgPicture.asset(
              bancoIcon,
              width: 15,
              color: Colors.grey,
            ),
          ]),
        ),
        focusColor: jBase,

        alignment: Alignment.centerRight,
        //icon:
        iconSize: 6,
      ),
    );
  }

  Container tipoCuentaSelect() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          //border: Border.all(color: jBase),
          //borderRadius: BorderRadius.circular(40),
          ),
      child: DropdownButton(
        items: tipoCuenta.map((String tipoCuentaV) {
          return DropdownMenuItem(
              value: tipoCuentaV, child: Row(children: [Text(tipoCuentaV)]));
        }).toList(),

        onChanged: (value) {
          setState(() {
            vistaTipo = value.toString();
            tipoCuenta2 = value.toString();
          });
        },
        hint: SizedBox(
          width: MediaQuery.of(context).size.width - 54,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(vistaTipo),
            SvgPicture.asset(
              tipodeCuenta,
              width: 15,
              color: Colors.grey,
            ),
          ]),
        ),
        focusColor: jBase,

        alignment: Alignment.centerRight,
        //icon:
        iconSize: 6,
      ),
    );
  }
}
