import 'dart:io';
import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:joiedriver/register_login_chofer/registro/user_data_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../components/default_button_chofer.dart';
import '../../../verify_screen/components/functions.dart';
import '../../conts.dart';
import '../../datos_bancos/datos_banco.dart';
import '../../size_config.dart';
import '../../../components/error_form.dart';
import 'package:date_field/date_field.dart';
import 'package:url_launcher/url_launcher.dart';


class RegistroForm extends StatefulWidget {
  const RegistroForm({Key? key}) : super(key: key);

  @override
  State<RegistroForm> createState() => _RegistroFormState();
}

class _RegistroFormState extends State<RegistroForm> {
  bool isHiddenPassword = true;
  final TextEditingController _controllerTextName = TextEditingController();
  final TextEditingController _controllerTextLastName = TextEditingController();
  final TextEditingController _controllerTextPassword = TextEditingController();
  final TextEditingController _controllerTextReferenceCode = TextEditingController();
  final TextEditingController _controllerTextPhone = TextEditingController();
  final TextEditingController _controllerTextAddress = TextEditingController();
  final TextEditingController _controllerTextCity = TextEditingController();
  final TextEditingController _controllerTextPlaca = TextEditingController();
  final TextEditingController _controllerTextMarca = TextEditingController();
  String? _controllerTextDate;
  String? sexo;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();

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
    return Form(
      key: _formKey,
      child: Column(children: [
        space(),
        codeRefFormField(),
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
        cityFormField(),
        spaceMedium(),
        placaFormField(),
        spaceMedium(),
        markCarField(),
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
        ButtonDefChofer(
            text: 'Continuar',
            press: () async {
              _controllerTextPassword.text = _controllerTextPassword.text.replaceAll(" ", "");
              _email.text = _email.text.replaceAll(" ", "");
              if (_formKey.currentState!.validate() && errors.isEmpty  ) {
                //escribir datos a sincronizar

              if( sexo != null && _controllerTextDate != null){
                if(_controllerTextReferenceCode.text.isEmpty){
                  //_controllerTextReferenceCode.text = "3050593811";
                  // showDialog<String>(
                  //   context: context,
                  //   builder: (BuildContext context) => AlertDialog(
                  //     content: alert(),
                  //     contentPadding: const EdgeInsets.all(10.0),
                  //     shape: const RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(40.0))
                  //     ),
                  //     elevation: 48,
                  //   ),
                  // );
                  showToast("Ingrese un Código de Referido");
                }else{
                  try {
                    var result = await  InternetAddress.lookup('google.com');
                    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _email.text.toString(),
                            password: "SuperSecretPassword!7770#"
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          //se genera el codigo de referido
                          Iterable<String> binarys = _email.text.codeUnits.map((int strInt) => strInt.toRadixString(2));
                          Crc32 hash =  Crc32();
                          for (var i in binarys) {
                            hash.add([int.parse(i)]);
                          }

                          RegisterUser user = RegisterUser(
                            name: _controllerTextName.text,
                            lastName: _controllerTextLastName.text,
                            email: _email.text.replaceAll(" ", ""),
                            address: _controllerTextAddress.text,
                            referenceCode: _controllerTextReferenceCode.text,
                            phone: _controllerTextPhone.text.replaceAll(" ", ""),
                            placa: _controllerTextPlaca.text,
                            marca: _controllerTextMarca.text,
                            date: _controllerTextDate!,
                            password: _controllerTextPassword.text.replaceAll(" ", ""),
                            documentVehicle: null,
                            documentTarjetaPropiedad: null,
                            documentAntecedentes: null,
                            genero: sexo!,
                            code: hash.hash.toString(),
                            photoPerfil: null,
                            cedula: null,
                            cedulaR: null,
                            licencia: null,
                            licenciaR: null, bank: null,
                            numberBank: null,
                            dateCi: null,
                            nameComplete: null,
                            numberCi: null,
                            typeBank: null, city: _controllerTextCity.text,
                          );
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                 //builder: (context) => ProfilePhoto(user)));
                                   builder: (context) =>  DatosBanco(user)));
                          //processGenerateCodeAndSendEmail(context: context, email: _email.text.replaceAll(" ", ""), username: _controllerTextName.text + " " + _controllerTextLastName.text);
                        } else if (e.code == 'wrong-password') {
                          showToast("El Email Ya Esta Registrado.\nIntente Iniciar Sesion o \nRecuperar la Contraseña");
                        }
                      }
                    }
                  } on SocketException catch (e) {
                    showToast("Debes tener acceso a internet para registrarte\n" + e.toString());
                  }
                }
              }else{
                if(sexo == null){
                 showToast("Por favor Ingrese su Genero");
                }else if(_controllerTextDate == null){
                  showToast( "Por favor Ingrese su fecha de nacimiento");
                }
              }
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
          suffixIcon:  Padding(
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
      autocorrect: false,
      keyboardType: const TextInputType.numberWithOptions(signed: true),
      decoration: InputDecoration(
          hintText: "Ingresa el código de socio",
          labelText: "Código de socio",
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
      decoration:  BoxDecoration(
        border: Border.all(color: jBase),
        borderRadius: BorderRadius.circular(40),
      ),
      child: DropdownButton(
        underline: const SizedBox(),
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

        SizedBox(
          width: MediaQuery.of(context).size.width-65,
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

  TextFormField cityFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _controllerTextCity,
      onSaved: (newValue) => city = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(cityError)) {
          removeError(error: cityError);
          return;
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(cityError)) {
          addError(error: cityError);
          return;
        }

        return null;
      },
      keyboardType: TextInputType.streetAddress,
      autocorrect: true,
      decoration: InputDecoration(
          hintText: "Ingresa tu Ciudad",
          labelText: "Ciudad",
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

  TextFormField placaFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _controllerTextPlaca,
      onSaved: (newValue) => carPlaca = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(carPlacaError)) {
          removeError(error: carPlacaError);
          setState(() {});
          return;
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(carPlacaError)) {
          addError(error: carPlacaError);
          return;
        }

        return null;
      },
      autocorrect: true,
      decoration: InputDecoration(
          hintText: "Ingresa la placa del vehículo",
          labelText: "Placa del vehículo",
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
            ),
            child: Icon(
              Icons.card_membership,
              size: getPropertieScreenWidth(18),
            ),
          )),
    );
  }

  TextFormField markCarField() {

    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _controllerTextMarca,
      onSaved: (newValue) => carMark = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(carMarkError)) {
          removeError(error: carMarkError);
          setState(() {});
          return;
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(carMarkError)) {
          addError(error: carMarkError);
          return "";
        }

        return null;
      },
      autocorrect: true,
      decoration: InputDecoration(
          hintText: "Ingresa la Marca de tu Vehículo",
          labelText: "Marca del Vehículo",
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
              getPropertieScreenWidth(18),
            ),
            child: Icon(
              Icons.car_repair,
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

  Widget alert() {
    return  SizedBox(
      height: 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ElevatedButton(onPressed: (){
                  Navigator.pop(context);
              }, child: SvgPicture.asset("assets/icons/x.svg", height: 20,),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: jBase,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(0.0),
              ),

              ),
              const Text("¿No tienes Código\nde socio?", style: TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
          SvgPicture.asset("assets/icons/whatsapp.svg", height: 100,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                )
              ),
              onPressed: (){
            _launch("whatsapp://send?text=Saludos me podrían dar información acerca de los códigos dee referidos, voy como Conductor&phone=573128423060");
          }, child: const Text("Contátanos", style: TextStyle(color: Colors.white),))
        ],
      ),
    );
  }

  _launch(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      if (kDebugMode) {
        print("Not supported");
      }
    }
  }
}
