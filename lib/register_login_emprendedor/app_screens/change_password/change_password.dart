import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../conts.dart';
import '../appbar.dart';
import '../ganancias/ganancias.dart';
import 'components/components.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  validarPassword() async {
    try {
      //recojo el email guardado en local
      String email = await encryptedSharedPreferences.getString('email');
      //verificamos que las credenciales sean corredctas (email y contraseña)
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email, password: passwordController.text);

      //obtenemos el usuario
      User? user = userCredential.user;

      //Actuaslizamos la password
      user?.updatePassword(newPasswordController.text);
      //guardamos la nueva contraseña en local
      await encryptedSharedPreferences.setString(
          'passwd', newPasswordController.text.toString());

      showToast("Contraseña Actualizada con Exito!");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Ganancias()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast("Este Email no esta registrado");
      } else if (e.code == 'wrong-password') {
        textError = true;
        messageError = "Contraseña Incorrecta";
      }
    } catch (e) {
      showToast(e.toString());
    }
  }

  String password = "";
  TextEditingController passwordController =
      TextEditingController(); //Controlador de la contraseña
  TextEditingController newPasswordController =
      TextEditingController(); //Controlador de la nueva contraseña
  TextEditingController confirmNewPasswordController =
      TextEditingController(); //Controlador de la confirmacion de la nueva contraseña

  bool textError =
      false; //textError sera usado para detectar error en los campos de texto por parte del usuario como por ejemplo escribir mal la contraseña
  String messageError =
      ""; //messageError sera el mensaje respectivo que sera enviado si textError llega a ser true
  EncryptedSharedPreferences encryptedSharedPreferences =
      EncryptedSharedPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarEmprendedor(
          accion: [], leading: back(context), title: 'Cambiar Contraseña'),
      body: ListView(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        children: [
          const SizedBox(
            height: 20,
          ),
          des("Contraseña actual"),
          inputText("Contraseña actual", passwordController),
          const SizedBox(
            height: 20.0,
          ),
          des("Contraseña nueva"),
          inputText("Contraseña nueva", newPasswordController),
          const SizedBox(height: 20.0),
          des("Repita contraseña"),
          inputText("Repita contraseña", confirmNewPasswordController),
          //A continuacion insertamos esta pieza de codigo para decir que si textError es falso, es decir, el usuario no ha cometido faltas, entonces retornara un container vacio.
          (!textError
              ? const SizedBox(
                  height: 20,
                )
              //En caso de que textError sea true, es decir, el usuario ha cometido alguna falta al intentar cambiar la contaseña, entonces mandará el valor de messageError con su texto respectivo
              : Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          messageError,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                )),
          const SizedBox(
            height: 30,
          ),

          Center(
            child: Container(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                "assets/images/cambioDeContrasenaIlustracion.svg",
                width: MediaQuery.of(context).size.width * .75,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: btnContinue(() async {
              //Aca encontramos 3 condicionales para los campos de password. Este primer if nos dice que si alguno de los campos de texto está vacío entonces le dara a textError un valor de true (lo que indica que algo ha fallado por parte del usuario) y tambien cambiara el valor de messageError al error respectivo
              if (passwordController.text == "" ||
                  newPasswordController.text == "" ||
                  confirmNewPasswordController.text == "") {
                textError = true;
                messageError = "Por favor complete todos los campos";
                //Aca tenemos la segunda condicional que dice que si la nueva contraseña y la de verificacion no son iguales entonces le dara a textError un valor de true (lo que indica que algo ha fallado por parte del usuario) y le dara a messageError el mensaje de error respectivo
              } else if (newPasswordController.text !=
                  confirmNewPasswordController.text) {
                textError = true;
                messageError = "Las Contraseñas no coinciden";
              } else if (newPasswordController.text ==
                  passwordController.text) {
                textError = true;
                messageError =
                    "Las Nueva Contraseña no debe ser igual a la anterior";
              } else if (newPasswordController.text.length < 8) {
                textError = true;
                messageError =
                    "Las Nueva Contraseña debe tener al menos 8 caracteres";
              } else {
                //En caso de que no hayan campos vacios y que las claves coincidan entonces todo marchara correctamente
                validarPassword();
              }

              setState(() {});
            }),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
