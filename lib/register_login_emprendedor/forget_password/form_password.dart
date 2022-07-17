import 'package:flutter/material.dart';
import '../../components/default_button.dart';
import '../../components/error_form.dart';
import '../conts.dart';
import '../size_config.dart';


class ForgotFormPassword extends StatefulWidget {
  const ForgotFormPassword({Key? key}) : super(key: key);

  @override
  State<ForgotFormPassword> createState() => _ForgotFormPasswordState();
}

class _ForgotFormPasswordState extends State<ForgotFormPassword> {
  final _formKey = GlobalKey<FormState>();

  final List<String> errors = [];
  late String email;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          //TODO: Validador de Forma
          TextFormField(
            onSaved: (newValue) => email = newValue!,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(emailNull)) {
                setState(() {
                  errors.remove(emailNull);
                });
              } else if (emailValidator.hasMatch(value) &&
                  errors.contains(emailError)) {
                setState(() {
                  errors.remove(emailError);
                });
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty && !errors.contains(emailNull)) {
                setState(() {
                  errors.add(emailNull);
                });
              } else if (!emailValidator.hasMatch(value) &&
                  !errors.contains(emailError)) {
                setState(() {
                  errors.add(emailError);
                });
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
          ),
      
          SizedBox(
            height: getPropertieScreenHeight(30),
          ),
          //TODO: Forma de Error
          FormError(errors: errors),
          SizedBox(
            height: SizeConfig.screenHeight * 0.09,
          ),
          //TODO: Boton de Contraseña
          ButtonDef(
            text: 'Continuar',
            press: () {
              if (_formKey.currentState!.validate()) {
                //Validar y reenviar para resetear contraseña
              }
            },
          ),
        ]));
  }
}
