import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joiedriver/components/default_button_chofer.dart';
import 'package:joiedriver/conts.dart';
import 'package:joiedriver/registro/bloc/registro_bloc.dart';
import 'package:joiedriver/registro/bloc/registro_data.dart';
import 'package:joiedriver/registro/pages/datos_bancos/datos_banco.dart';
import 'package:joiedriver/sign_in/components/error_form.dart';
import 'package:joiedriver/singletons/carro_data.dart';
import 'package:joiedriver/size_config.dart';

import '../../profile_photo/profile_photo.dart';

class VehicleForm extends StatefulWidget {
  const VehicleForm({Key? key}) : super(key: key);

  @override
  State<VehicleForm> createState() => VehicleFormState();
}

class VehicleFormState extends State<VehicleForm> {
  final List<String> errors = [];
  String? tipoCuenta2;
  String placa = '';
  String marca = '';
  String year = '';
  VehicleType type = VehicleType.particular;
  String color = '';
  int capacidad = 1;
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

  void _init() {
    placa = data?.registroDataVehiculo?.placa ?? '';
    marca = data?.registroDataVehiculo?.marca ?? '';
    year = data?.registroDataVehiculo?.year ?? '';
    type = data?.registroDataVehiculo?.type ?? VehicleType.particular;
    color = data?.registroDataVehiculo?.color ?? '';
    capacidad = data?.registroDataVehiculo?.capacidad ?? 1;
  }

  @override
  void initState() {
    data = (context.read<RegistroBloc>().state as UpdateRegistroState).userData;
    _init();
    super.initState();
  }

  RegistroData? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        placaFormField(),
        spaceMedium(),
        marcaFormField(),
        spaceMedium(),
        yearFormField(),
        spaceMedium(),
        typeSelect(),
        spaceMedium(),
        colorFormField(),
        spaceMedium(),
        capacidadFormField(),
        spaceMedium(),
        FormError(errors: errors),
        spaceMedium(),
        ButtonDefChofer(
          text: 'Siguiente',
          press: () {
            data!.registroDataVehiculo!.placa = placa;
            data!.registroDataVehiculo!.marca = marca;
            data!.registroDataVehiculo!.year = year;
            data!.registroDataVehiculo!.type = type;
            data!.registroDataVehiculo!.color = color;
            data!.registroDataVehiculo!.capacidad = capacidad;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DatosBanco()));
          },
        )
      ],
    );
  }

  SizedBox spaceMedium() {
    return SizedBox(
      height: getPropertieScreenHeight(30),
    );
  }

  TextFormField placaFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => placa = newValue!,
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
          hintText: "Ingresa la placa",
          labelText: "Placa",
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
            ),
            child: Icon(
              Icons.abc_outlined,
              size: getPropertieScreenWidth(18),
            ),
          )),
    );
  }

  TextFormField marcaFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => marca = newValue!,
      validator: (value) {
        if (value!.isEmpty && !errors.contains('Porfavor ingresa la marca')) {
          addError(error: 'Porfavor ingresa la marca');
          return;
        }

        return null;
      },
      autocorrect: true,
      keyboardType: TextInputType.number,
      maxLength: 10,
      decoration: InputDecoration(
          hintText: "Ingresa la marca",
          labelText: "Marca",
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

  TextFormField colorFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => color = newValue!,
      validator: (value) {
        if (value!.isEmpty && !errors.contains('Porfavor ingresa el color')) {
          addError(error: 'Porfavor ingresa el color');
          return;
        }

        return null;
      },
      autocorrect: true,
      keyboardType: TextInputType.number,
      maxLength: 10,
      decoration: InputDecoration(
          hintText: "Ingresa el color",
          labelText: "Color",
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

  TextFormField capacidadFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => capacidad = int.parse(newValue ?? ''),
      validator: (value) {
        if (value!.isEmpty &&
            !errors.contains('Porfavor ingresa la capacidad')) {
          addError(error: 'Porfavor ingresa la capacidad');
          return;
        }

        return null;
      },
      autocorrect: true,
      keyboardType: TextInputType.number,
      maxLength: 2,
      decoration: InputDecoration(
          hintText: "Ingresa la capacidad",
          labelText: "Capacidad",
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

  TextFormField yearFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: controllerTextNumber,
      onSaved: (newValue) => numberAccount = newValue,
      onChanged: (value) {
        if (value.isNotEmpty &&
            errors.contains('Porfavor escribe el ano de tu vehiculo')) {
          removeError(error: 'Porfavor escribe el ano de tu vehiculo');
          setState(() {});
          return;
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty &&
            !errors.contains('Porfavor escribe el ano de tu vehiculo')) {
          addError(error: 'Porfavor escribe el ano de tu vehiculo');
          return;
        }

        if (value.length < 4 &&
            !errors.contains('Formato de ano no soportado')) {
          addError(error: 'Formato de ano no soportado');
          return;
        }

        return null;
      },
      keyboardType: TextInputType.number,
      maxLength: 4,
      decoration: InputDecoration(
          hintText: "Ingresa el ano de tu vehiculo",
          labelText: "Ano",
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

  Container typeSelect() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          //border: Border.all(color: jBase),
          //borderRadius: BorderRadius.circular(40),
          ),
      child: DropdownButton(
        items: VehicleType.values.map((VehicleType tipoVehiculo) {
          return DropdownMenuItem(
              value: tipoVehiculo,
              child: Row(children: [Text(tipoVehiculo.name)]));
        }).toList(),

        onChanged: (value) {
          setState(() {
            type = value as VehicleType;
          });
        },
        hint: SizedBox(
          width: MediaQuery.of(context).size.width - 54,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(type.name),
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
