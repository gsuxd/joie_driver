import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/default_button.dart';
import '../../components/error_form.dart';
import '../conts.dart';
import '../forget_password_sucess/forget_password.dart';
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
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          //TODO: Validador de Forma
          TextFormField(
            controller: emailController,
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
                sendEmail();
              }
            },
          ),
        ]));
  }

  Future sendEmail () async{
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      String emailAddress = emailController.text;
      await auth.sendPasswordResetEmail(email: emailAddress);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ForgotPasswordScreenSucess()));

    } on FirebaseAuthException catch (error) {
      showToast(error.toString());
    }
  }
}
