import 'dart:math';
import 'package:flutter/material.dart';
import '../verify_screen.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

//Funcion sendEmail se encargara de conectarse a la api de emailjs al igual que de "configurar" todo lo necesario
Future<bool> sendEmail({required String email, required String username, required int code}) async {
  const String  usernameHost = 'dae8eb3422e62e';
  const String passwordHost = '744ac90006953f';

  //configuracion del servidor de correo
  SmtpServer smtpServer =
  SmtpServer(
    'smtp.mailtrap.io',
    port: 2525,
    username: usernameHost,
    password: passwordHost,

  );
  // mensaje a enviar
  final message = Message()
    ..from = Address(email, username)
    ..recipients.add(email)
    ..subject = 'Verificación de correo ${DateTime.now()}'
    ..text = 'Código de Verificación'
    ..html = "<h1>Código para Registro en Joiedriver</h1>\n<p>"+ code.toString() +"</p>";


  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
    return true;
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
    return false;
  }

}

//generateCode servira para generar un numero aleatorio entre un minimo y
// un maximo. Esto es para la generacion del codigo de autenticacion.
// Por lo general los codigos de autenticacion son de 6 digitos, lo que
// significa que sera un numero del 100.000 al 999.999. Por ende, la probabilidad
// de que a un usuario le toque el mismo codigo dos veces o que a dos distintos
// usuarios les toque el mismo codigo es de 1 en 1.000.000 ( 0.0001 % )
generateCode(min, max) {
  Random random = Random(); //Creamos la variable random de tipo Math.Random
  return min +
      random.nextInt(
          max - min); //para generar un numero aleatorio entre min y max
}

//en processGenerateCodeAndSendEmail tenemos los parametros email (email del usuario)
// y context (Build context) este servira para automaticamente enviar el correo con el
// codigo de verificacion. En otras palabras, esta es la funcion que se ejecutara al
// presionar el boton de registrar
processGenerateCodeAndSendEmail({required email, required username, required context}) {
  //numero aleatorio entre 100000 y 999999 (como se menciono antes). Esta variable no
  // solo se enviara al correo sino que tambien se pasara a la pantalla de verificacion
  // para poder autenticar
  int codeForEmail = generateCode(100000, 999999);
  print(codeForEmail.toString());
  //Llamamos a sendEmail y le pasamos el email del usario y codeForEmail
  Future<bool> send = sendEmail(email: email, username: username, code: codeForEmail);

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => VerifyScreen(
        email: email,
        code: codeForEmail,
      ),
    ),
  ); //Luego de enviar el correo se enviara a una pantalla llamada VerifyScreen a la cual
  //se le pasaran las variables email y code para la autenticacion
}

//En verifyCode se hara una condicional entre code y codeFromForm
 verifyCode(code, codeFromForm) {
  if (code == codeFromForm) {
    print("true");
     //Si los codigos coinciden, todo bien. Usuario verificado
  } else {
    print("false");
     //Si no, manda un error
  }
}
