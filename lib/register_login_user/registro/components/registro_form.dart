import 'dart:io';
import 'package:archive/archive.dart';
import 'package:joiedriver/register_login_user/registro/user_data_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../register_login_user/profile_photo/profile_photo.dart';
import '../../conts.dart';
import '../../size_config.dart';
import '../../../components/default_button.dart';
import '../../../components/error_form.dart';
import 'package:date_field/date_field.dart';


class RegistroForm extends StatefulWidget {
  const RegistroForm({Key? key}) : super(key: key);

  @override
  State<RegistroForm> createState() => _RegistroFormState();
}

class _RegistroFormState extends State<RegistroForm> {
  bool isHiddenPassword = true;
  TextEditingController _controllerTextName = TextEditingController();
  TextEditingController _controllerTextLastName = TextEditingController();
  TextEditingController _controllerTextPassword = TextEditingController();
  TextEditingController _controllerTextPhone = TextEditingController();
  TextEditingController _controllerTextAddress = TextEditingController();


  String? _controllerTextDate;
  String? sexo;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  @override
  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  @override
  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        space(),
        nombreFormField(),
        spaceMedium(),
        apellidoFormField(),
        spaceMedium(),
        dateTimeFormField(),
        spaceMedium(),
        generFormField(),
        spaceMedium(),
        phoneNumberFormField(),
        spaceMedium(),
        addressFormField(),
        spaceMedium(),
        emailFormField(),
        spaceMedium(),
        passwordField(),
        spaceMedium(),
        resPasswordField(),
        SizedBox(
          height: getPropertieScreenHeight(10),
        ),
        FormError(errors: errors),
        spaceMedium(),
        ButtonDef(
            text: 'Continuar',
            press: () async {
              _controllerTextPassword.text = _controllerTextPassword.text.replaceAll(" ", "");
              _email.text = _email.text.replaceAll(" ", "");
              if (_formKey.currentState!.validate() && errors.length < 1  ) {
                //escribir datos a sincronizar

              if( sexo != null && _controllerTextDate != null){

                try {
                  var result = await  InternetAddress.lookup('google.com');
                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    print('connected');
                    try {
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _email.text.toString(),
                          password: "SuperSecretPassword!7770#"
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('El usuario no esta registrado');


                        //se genera el codigo de referido
                        Iterable<String> binarys = _email.text.codeUnits.map((int strInt) => strInt.toRadixString(2));
                        Crc32 hash = new Crc32();
                        for (var i in binarys) {
                          hash.add([int.parse(i)]);
                        }

                        print(hash.hash);

                        RegisterUser user = RegisterUser(
                            name: _controllerTextName.text,
                            lastName: _controllerTextLastName.text,
                            email: _email.text.replaceAll(" ", ""),
                            address: _controllerTextAddress.text,
                            phone: _controllerTextPhone.text.replaceAll(" ", ""),
                            date: _controllerTextDate!,
                            password: _controllerTextPassword.text.replaceAll(" ", ""),
                            documentId: null,
                            photoPerfil: null,
                            documentAntecedentes: null,
                            genero: sexo!,
                            code: hash.hash.toString(),
                            cedulaR: null,
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePhoto(user)));
                      } else if (e.code == 'wrong-password') {
                        print('El usuario ya esta Registrado');
                        showToast("El Email Ya Esta Registrado.\nIntente Iniciar Sesion o \nRecuperar la Contraseña");
                      }
                    }
                  }
                } on SocketException catch (e) { 
                  print('not connected');
                  showToast("Debes tener acceso a internet para registrarte");
                }
              }else{
                if(sexo == null){
                 showToast("Por favor Ingrese su Genero");
                }else if(_controllerTextDate == null){
                  showToast( "Por favor Ingrese su fecha de nacimiento");
                }
              }
                //Navigator.pushNamed(context, CompleteProfile.routeName);
              }
            })
      ]),
    );
  }

  SizedBox spaceMedium() {
    return SizedBox(
        height: getPropertieScreenHeight(30),
      );
  }

  SizedBox space() {
    return SizedBox(
        height: getPropertieScreenHeight(15),
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
      controller:_controllerTextName ,
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
          setState(() {

          });
        } else if (emailValidator.hasMatch(value) &&
            errors.contains(emailError)) {
          removeError(error: emailError);
          setState(() {

          });
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
      obscureText: isHiddenPassword,
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
            child: GestureDetector(
              onTap: statePassword,
              child: Icon(
                isHiddenPassword ? Icons.visibility : Icons.visibility_off,
                size: getPropertieScreenWidth(18),
              ),
            ),
          )),
    );
  }

  TextFormField resPasswordField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => conformPassword = newValue,
      obscureText: isHiddenPassword,
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
            child: GestureDetector(
              onTap: statePassword,
              child: Icon(
                isHiddenPassword ? Icons.visibility : Icons.visibility_off,
                size: getPropertieScreenWidth(18),
              ),
            ),
          )),
    );
  }
  void statePassword() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
  TextFormField nickNameFormField() {
    return TextFormField(

      onSaved: (newValue) => nickName = newValue,
      // onChanged: (value) {
      //   if (value.isNotEmpty && errors.contains(nickNameError)) {
      //     removeError(error: nickNameError);
      //     return;
      //   }
      //   return;
      // },
      // validator: (value) {
      //   if (value!.isEmpty && !errors.contains(nickNameError)) {
      //     addError(error: nickNameError);
      //     return "";
      //   }
      //
      //   return null;
      // },
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

  Container generFormField() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        //border: Border.all(color: jBase),
        //borderRadius: BorderRadius.circular(40),
      ),
      child: DropdownButton(
        items: generoList.map((String gender) {
          return DropdownMenuItem(value: gender, child: Row(children: [Text(gender)]));
        }).toList(),
        onChanged: (value) {
          setState(() {
            vista = value.toString();
            sexo = value.toString();
          });
        },
        hint:

        Container(
          width: MediaQuery.of(context).size.width-54,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
            margin: EdgeInsets.only(right: 1),
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
        print(diferencia?.inDays.toString());
        if(diferencia?.inDays.toInt() != null){
          if(diferencia!.inDays.toInt().abs() < 6573){
            return 'Debes ser mayor de edad para trabajar con nosotros';
          }

        }
        return null;
      },
      onDateSelected: (DateTime value) {
        print(value);
        _controllerTextDate = value.toString();
      },
    );
  }
}
