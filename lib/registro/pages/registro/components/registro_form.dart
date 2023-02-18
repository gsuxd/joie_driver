import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/conts.dart';
import 'package:joiedriver/helpers/generate_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:joiedriver/components/default_button_chofer.dart';
import 'package:joiedriver/components/error_form.dart';
import 'package:date_field/date_field.dart';
import 'package:joiedriver/registro/bloc/registro_data.dart';
import 'package:joiedriver/registro/pages/datos_bancos/datos_banco.dart';
import 'package:joiedriver/registro/bloc/registro_bloc.dart';
import 'package:joiedriver/registro/bloc/registro_enums.dart';
import 'package:joiedriver/registro/pages/datos_vehiculo/datos_vehiculo.dart';
import 'package:joiedriver/size_config.dart';

import '../../profile_photo/profile_photo.dart';

class RegistroForm extends StatefulWidget {
  const RegistroForm({Key? key}) : super(key: key);
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "registroPage";
  }

  @override
  State<RegistroForm> createState() => _RegistroFormState();
}

class _RegistroFormState extends State<RegistroForm> {
  final TextEditingController _controllerTextName = TextEditingController();
  final TextEditingController _controllerTextLastName = TextEditingController();
  final TextEditingController _controllerTextPassword = TextEditingController();
  final TextEditingController _controllerTextReferenceCode =
      TextEditingController();
  final TextEditingController _controllerTextPhone = TextEditingController();
  final TextEditingController _controllerTextAddress = TextEditingController();
  String? _controllerTextDate;
  String? sexo;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final List<String> errors = [];
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
  void initState() {
    super.initState();
    data = (context.read<RegistroBloc>().state as UpdateRegistroState).userData;
    _controllerTextAddress.text = data?.address ?? '';
    _controllerTextName.text = data?.name ?? '';
    _controllerTextLastName.text = data?.lastName ?? '';
    _controllerTextPassword.text = data?.password ?? '';
    _controllerTextReferenceCode.text = data?.referenceCode ?? '';
    _controllerTextPhone.text = data?.phone ?? '';
    _controllerTextDate = data?.date.toString();
    sexo = data?.genero;
    vista = data?.genero ?? 'Selecciona tu genero';
    _email.text = data?.email ?? '';
    setState(() {});
  }

  RegistroData? data;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        const Space(),
        codeRefFormField(),
        const Space(),
        nombreFormField(),
        const SpaceMedium(),
        apellidoFormField(),
        const SpaceMedium(),
        dateTimeFormField(),
        const SpaceMedium(),
        generFormField(),
        const SpaceMedium(),
        phoneNumberFormField(),
        const SpaceMedium(),
        addressFormField(),
        const SpaceMedium(),
        emailFormField(),
        const SpaceMedium(),
        passwordField(),
        const SpaceMedium(),
        resPasswordField(),
        SizedBox(
          height: getPropertieScreenHeight(10),
        ),
        FormError(errors: errors),
        const SpaceMedium(),
        ButtonDefChofer(
            text: 'Continuar',
            press: () async {
              _controllerTextPassword.text =
                  _controllerTextPassword.text.trim();
              _email.text = _email.text.trim();
              await _verifyCode();
              if (_formKey.currentState!.validate() && errors.isEmpty) {
                if (sexo != null && _controllerTextDate != null) {
                  if (_controllerTextReferenceCode.text.isEmpty) {
                    _controllerTextReferenceCode.text = "JoieDriver";
                  }

                  try {
                    var result = await InternetAddress.lookup('google.com');
                    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _email.text.toString(),
                            password: "SuperSecretPassword!7770#");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          final data = (context.read<RegistroBloc>().state
                                  as UpdateRegistroState)
                              .userData;
                          data.name = _controllerTextName.text;
                          data.lastName = _controllerTextLastName.text;
                          data.email = _email.text.replaceAll(" ", "");
                          data.address = _controllerTextAddress.text;
                          data.referenceCode =
                              _controllerTextReferenceCode.text;
                          data.phone =
                              _controllerTextPhone.text.replaceAll(" ", "");
                          data.date = _controllerTextDate!;
                          data.password =
                              _controllerTextPassword.text.replaceAll(" ", "");
                          data.genero = sexo!;
                          data.code = await compute(
                              generateCode, _email.text.trim(),
                              debugLabel: "generateCode");
                          Widget nextPage;
                          switch (data.type) {
                            case UserType.pasajero:
                              nextPage = const ProfilePhoto();
                              break;
                            case UserType.chofer:
                              nextPage = const DatosVehiculo();
                              break;
                            default:
                              nextPage = const DatosBanco();
                          }
                          context.read<RegistroBloc>().add(
                              NextScreenRegistroEvent(context, nextPage, data));
                        } else if (e.code == 'wrong-password') {
                          showToast(
                              "El Email Ya Esta Registrado.\nIntente Iniciar Sesion o \nRecuperar la Contraseña");
                        }
                      }
                    }
                  } on SocketException catch (e) {
                    showToast(
                        "Debes tener acceso a internet para registrarte\n" +
                            e.toString());
                  }
                } else {
                  if (sexo == null) {
                    showToast("Por favor Ingrese su Genero");
                  } else if (_controllerTextDate == null) {
                    showToast("Por favor Ingrese su fecha de nacimiento");
                  }
                }
              }
            })
      ]),
    );
  }

//Métodos de Confirmación y validación de cada forma
  TextFormField apellidoFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _controllerTextLastName,
      onSaved: (newValue) => lastName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(apeNull)) {
          removeError(error: apeNull);
          return;
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(apeNull)) {
          addError(error: apeNull);
          return "";
        }

        return null;
      },
      keyboardType: TextInputType.name,
      autocorrect: true,
      decoration: InputDecoration(
          hintText: "Ingresa tus Apellidos",
          labelText: "Apellidos",
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

  TextFormField nombreFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _controllerTextName,
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
          hintText: "Ingresa tus Nombres",
          labelText: "Nombres",
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

  TextFormField direccionFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _controllerTextAddress,
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
          hintText: "Ingresa tu Direccion",
          labelText: "Nombres",
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

  TextFormField emailFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _email,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(emailNull)) {
          removeError(error: emailNull);
          setState(() {});
        } else if (emailValidator.hasMatch(value) &&
            errors.contains(emailError)) {
          removeError(error: emailError);
          setState(() {});
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(emailNull)) {
          addError(error: emailNull);
          return null;
        } else if (!emailValidator.hasMatch(value) &&
            !errors.contains(emailError)) {
          addError(error: emailError);
          return null;
        }

        return null;
      },
      keyboardType: TextInputType.emailAddress,
      autocorrect: true,
      decoration: InputDecoration(
          hintText: "Ingresa tu correo",
          labelText: "Correo",
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
            ),
            child: Icon(
              Icons.email_rounded,
              size: getPropertieScreenWidth(18),
            ),
          )),
    );
  }

  TextFormField passwordField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _controllerTextPassword,
      onSaved: (newValue) => password = newValue!,
      obscureText: true,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(passNull)) {
          setState(() {
            errors.remove(passNull);
          });
        } else if (value.length >= 8 && errors.contains(passError)) {
          setState(() {
            errors.remove(passError);
          });
        }
        password = value;
        return;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(passNull)) {
          setState(() {
            errors.add(passNull);
          });
          return "";
        } else if (value.length < 8 && !errors.contains(passError)) {
          setState(() {
            errors.add(passError);
          });
          return "";
        }

        return null;
      },
      decoration: InputDecoration(
          hintText: "Ingresa tu contraseña",
          labelText: "Contraseña",
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
            ),
            child: Icon(
              Icons.key,
              size: getPropertieScreenWidth(18),
            ),
          )),
    );
  }

  TextFormField resPasswordField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => conformPassword = newValue,
      obscureText: true,
      onChanged: (value) {
        if (password != conformPassword) {
          setState(() {
            errors.remove(machError);
            errors.remove(reNull);
          });
        }

        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            errors.add(reNull);
          });
          return "";
        } else if (password != value) {
          setState(() {
            errors.add(machError);
          });
          return "";
        }

        return null;
      },
      decoration: InputDecoration(
          hintText: "Ingrese otra vez su contraseña",
          labelText: "Confirme su contraseña",
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
            ),
            child: Icon(
              Icons.key,
              size: getPropertieScreenWidth(18),
            ),
          )),
    );
  }

  TextFormField nickNameFormField() {
    return TextFormField(
      onSaved: (newValue) => nickName = newValue,
      autocorrect: true,
      decoration: InputDecoration(
          hintText: "Ingresa Codigo de referido (opcional)",
          labelText: "Codigo de Referido",
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
            ),
            child: Icon(
              Icons.code,
              size: getPropertieScreenWidth(18),
            ),
          )),
    );
  }

  TextFormField codeRefFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _controllerTextReferenceCode,
      onSaved: (newValue) => codeRef = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(codeError)) {
          removeError(error: codeError);
          return;
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(codeError)) {
          addError(error: codeError);
          return;
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: "Ingresa el código de Lider",
          labelText: "Código de Lider",
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
            ),
            child: Icon(
              Icons.code,
              size: getPropertieScreenWidth(18),
            ),
          )),
    );
  }

  Future<bool> _verifyCode() async {
    if (_controllerTextReferenceCode.text.trim() == "JoieDriver") {
      return true;
    }
    final parentChofer = await FirebaseFirestore.instance
        .collection(
          'users',
        )
        .where('code', isEqualTo: _controllerTextReferenceCode.text.trim())
        .get();
    if (parentChofer.size == 0) {
      final parentEmprendedor = await FirebaseFirestore.instance
          .collection(
            'usersEmprendedor',
          )
          .where('code', isEqualTo: _controllerTextReferenceCode.text.trim())
          .get();

      if (parentEmprendedor.size == 0) {
        return false;
      }
    }
    return true;
  }

  Container generFormField() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          //border: Border.all(color: jBase),
          //borderRadius: BorderRadius.circular(40),
          ),
      child: DropdownButton(
        items: generoList.map((String gender) {
          return DropdownMenuItem(
              value: gender, child: Row(children: [Text(gender)]));
        }).toList(),
        onChanged: (value) {
          setState(() {
            vista = value.toString();
            sexo = value.toString();
          });
        },
        hint: SizedBox(
          width: MediaQuery.of(context).size.width - 54,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(vista),
            SvgPicture.asset(
              genero,
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

  TextFormField addressFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _controllerTextAddress,
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(addressError)) {
          removeError(error: addressError);
          return;
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(addressError)) {
          addError(error: addressError);
          return;
        }

        return null;
      },
      keyboardType: TextInputType.streetAddress,
      autocorrect: true,
      decoration: InputDecoration(
          hintText: "Ingresa tu domicilio",
          labelText: "Dirección",
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
            ),
            child: Icon(
              Icons.location_city,
              size: getPropertieScreenWidth(18),
            ),
          )),
    );
  }

  TextFormField phoneNumberFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _controllerTextPhone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(phoneError)) {
          removeError(error: phoneError);
          return;
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(phoneError)) {
          addError(error: phoneError);
          return "";
        }

        return null;
      },
      keyboardType: TextInputType.phone,
      autocorrect: true,
      decoration: InputDecoration(
          hintText: "Ingresa tu Número teléfónico",
          labelText: "Teléfono",
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
            ),
            child: Icon(
              Icons.phone,
              size: getPropertieScreenWidth(18),
            ),
          )),
    );
  }

  DateTimeFormField dateTimeFormField() {
    return DateTimeFormField(
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: const EdgeInsets.all(13),
          child: Container(
            margin: const EdgeInsets.only(right: 1),
            width: 2,
            height: 2,
            child: SvgPicture.asset(
              edad,
              width: 0.5,
              fit: BoxFit.fitWidth,
              color: Colors.grey,
            ),
          ),
        ),
        labelText: 'Fecha de Nacimiento',
        hintText: 'Ingrese su fecha de nacimiento',
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
        _controllerTextDate = value.toString();
      },
    );
  }
}

class Space extends StatelessWidget {
  const Space({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getPropertieScreenHeight(15),
    );
  }
}

class SpaceMedium extends StatelessWidget {
  const SpaceMedium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getPropertieScreenHeight(30),
    );
  }
}
