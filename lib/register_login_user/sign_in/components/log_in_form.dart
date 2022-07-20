import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../home/home.dart';
import '../../size_config.dart';
import '/components/default_button.dart';
import '../components/error_form.dart';
import '../../conts.dart';
import '/register_login_user/sign_in/components/fogot.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInForm();
}

class _SignInForm extends State<SignInForm> {
  bool isHiddenPassword = true;
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool remerber = false;

  @override
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
    // TODO: implement build

    // bool _isLoading = false;
    // bool _isLoading2 = false;
    // final _auth = ref.watch(authenticationProvider);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          _inputEmail(),
          SizedBox(
            height: getPropertieScreenHeight(30),
          ),
          _inputPassword(),
          SizedBox(
            height: getPropertieScreenHeight(30),
          ),
          // Row(
          //   children: [
          //     Checkbox(
          //         activeColor: jBase,
          //         value: remerber,
          //         onChanged: (value) {
          //           setState(() {
          //             remerber = value!;
          //           });
          //         }),
          //     const Text("Recuerdame"),
          //     const Spacer(),
          const ForgotButtom(),
          //     SizedBox(
          //       width: getPropertieScreenWidth(10),
          //     )
          //   ],
          // ),
          SizedBox(
            height: getPropertieScreenHeight(20),
          ),
          FormError(errors: errors),
          ButtonDef(
              text: "Ingresar",
              press: () async {

                //TODO: Validador del boton en el login
                if (_formKey.currentState!.validate()) {
                  print("entra");
                  _formKey.currentState!.save();
                try {
                  var result = await  InternetAddress.lookup('google.com');
                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    print('connected');
                    try {
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _email.text.toString(),
                          password: _password.text.toString()
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen("Bienvenido")));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showToast("Este Email no esta registrado");
                      } else if (e.code == 'wrong-password') {
                        showToast("Contraseña Incorrecta");
                      }
                    }catch (e) {
                      showToast(e.toString());
                    }
                  }
                }on SocketException catch (e) {
                  print('not connected');
                  showToast("Debes tener acceso a internet para registrarte");
                }

                  //Navigator.pushNamedAndRemoveUntil(
                  //    context, "/success", (route) => false);
                }
              }),
        ],
      ),
    );
  }

  Widget _inputPassword() {
    return TextFormField(
      controller: _password,
      obscureText: isHiddenPassword,
      onChanged: (password) {
        if (password.isNotEmpty && errors.contains(passNull)) {
          removeError(error: passNull);
          return;
        } else if (password.length >= 8 && errors.contains(passError)) {
          removeError(error: passError);
          return;
        }
        return;
      },
      validator: (password) {
        if (password!.isEmpty && !errors.contains(passNull)) {
          addError(error: passNull);
          return null;
        } else if (password.length < 8 && !errors.contains(passError)) {
          addError(error: passError);
          return null;
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
  void statePassword() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
  Widget _inputEmail() {
    return TextFormField(
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
}
