import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../components/states/states.dart';
import 'size_config.dart';

//Colores Generales de la App
const jBase = Color(0xFF005EA8);
const jSec = Color(0xFF2081F2);

const red = Color(0xffff0904);
const green = Colors.green;
const blue = Color(0xff0087f5);
const blueDark = Color(0xff005ea4);
const purple = Color.fromARGB(255, 156, 44, 176);

const Color colorIconInicio = blue;
const Color colorIconHistorial = blue;
const Color colorIconPerfil = blueDark;
const Color colorIconIngresos = blue;

const jGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [jBase, jSec]);

const jGSec = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [purple, jBase]);

const jtextColor = Color.fromARGB(255, 6, 38, 63);
const jtextColorSec = Color.fromARGB(255, 93, 110, 121);

const jDuration = Duration(milliseconds: 200);

//Imagenes svg
const String logo = "assets/images/logo.svg";
const String ilus1 = "assets/images/ilus1.svg";
const String ilus2 = "assets/images/ilustracion2.svg";
const String ilus3 = "assets/images/ilustracion3.svg";
const String ilus4 = 'assets/images/celgirl.svg';
const String facebook = 'assets/icons/facebook2.svg';
const String twitter = 'assets/icons/twitter2.svg';
const String google = 'assets/icons/google2.svg';
const String compartir = 'assets/icons/compartir.svg';
const String inicio = 'assets/icons/inicio.svg';
const String llamar = 'assets/icons/llamar.svg';
const String ingresos = 'assets/icons/ingresos.svg';
const String pedidos = 'assets/icons/pedidos.svg';
const String cancelarCarrera = 'assets/icons/cancelarCarrera.svg';
const String pedirAuto = 'assets/icons/pedirAuto.svg';
const String pedirAutoUst = 'assets/icons/pedirAutoUst.svg';
const String perfil = 'assets/images/perfil.svg';
const String perfilM = 'assets/icons/profile.svg';
const String desarrollo = 'assets/images/construccion.svg';
const String susscess = 'assets/icons/queexito.svg';
const String antePen = 'assets/icons/antecedentesPenales.svg';
const String adjun = 'assets/icons/adjuntarArchivo.svg';
const String historial = 'assets/icons/historial.svg';
const String notificaciones = 'assets/icons/notificaciones.svg';
const String generalUser = 'assets/icons/general_user.svg';
const String carnetPropiedad = 'assets/icons/carnetPropiedad.svg';
const String camara = 'assets/icons/camara.svg';
const String fotoAutmovil = 'assets/icons/fotoAutomovil.svg';
const String asistencaTec = 'assets/icons/asistencia_tecnica.svg';
const String fotoCarnet = 'assets/icons/fotoCarnet.svg';
const String perfilPrincipal = 'assets/icons/perfil_principal.svg';
const String exito = 'assets/icons/queexito.svg';
const String error = 'assets/icons/error.svg';
const String recargar = 'assets/icons/recargar.svg';
const String share = 'assets/icons/refiere-y-gana.svg';
const String edad = 'assets/icons/edad.svg';
const String profilePhoto = 'assets/icons/profile_photo.svg';
const String document_id = 'assets/icons/document_id.svg';
const String cedulaImg = 'assets/icons/cedula.svg';
const String cedularImg = 'assets/icons/cedula_reverso.svg';
const String licenciaImg = 'assets/icons/licencia.svg';

//Imagenes de prueba
const String chica2 = 'assets/images/girld2.jpg';
const String estrella3 = 'assets/images/estrella3.png';
const String estrella5 = 'assets/images/estrella5.png';
const String a = 'assets/images/A.png';
const String b = 'assets/images/B.png';
const String mapa = 'assets/images/mapa.png';

//imagenes y mensajes de onboarding screen
List splashD = [
  {"text": "Una carrera justa para todos", "image": logo},
  {"text": "Inicia como un Joie Driver", "image": ilus1},
  {"text": "Mira las ofertas de los Joiers", "image": ilus2},
  {"text": "Llega a todas partes con nosotros", "image": ilus3},
];

//datos de banco
const String cedulaNull = "Por favor ingresa tu número de cédula";
const String cedulaError = "Por favor ingresa un número de cédula correcto";
const String cuentaNull = "Por favor ingresa tu número de cuenta";
const String cuentaError = "Por favor ingresa un número de cuenta válido";
String? cedula;
String? numberAccount;
const String bancoIcon = 'assets/icons/banco.svg';
const String cedulaIcon = 'assets/icons/ceduladeidentidad.svg';
const String tipodeCuenta = 'assets/icons/tipodecuenta.svg';
String controllerTextDate = "0";
String vista = 'Selecciona tu genero';
String vistaCuenta = 'Selecciona tu banco';
String vistaTipo = 'Selecciona el tipo';
late String bancoFinal;
late String tipoCuentaValor;
List<String> generoList = ['Hombre', 'Mujer'];
List<String> tipoCuenta = ['Corriente', 'Ahorro'];
const String bogotaBank = 'assets/images/bogotabank.svg';
const String bancolombia = 'assets/images/bancolombia.svg';
const String bbva = 'assets/images/bbva.svg';
const String colpatria = 'assets/images/colpatria.svg';
const String davivienda = 'assets/images/Davivienda.svg';
const String nequi = 'assets/images/nequi.svg';
const String cash = 'assets/images/cash.png';
const String avvillas = 'assets/images/avvillas.svg';
const String bancamia = 'assets/images/Bancamía.svg';
const String bancoAgrario = 'assets/images/banco_agrario.svg';
const String bancoAvDibas = 'assets/images/banco_Av_Dibas.svg';
const String bancoCajaSocial = 'assets/images/banco_caja_social.svg';
const String bancoCoopCentral = 'assets/images/banco_Cooperativo_Coopcentral.svg';
const String credifinanciera = 'assets/images/banco_Credifinanciera.svg';
const String bancodeOccidente = 'assets/images/banco_de_occidente.svg';
const String falabella = 'assets/images/Banco_Falabella.svg';
const String finandia = 'assets/images/Banco_Finandina.svg';
const String itau = 'assets/images/banco_Itau.svg';
const String pichincha = 'assets/images/banco_Pichincha.svg';
const String bpc = 'assets/images/banco_polular_de_colombia.svg';
const String bancoW = 'assets/images/banco_W.svg';
const String bancoOmeva = 'assets/images/Bancoomeva.svg';
const String bancoldex = 'assets/images/Bancoldex.svg';
List<String> banco = [
  bancolombia,
  bogotaBank,
  bbva,
  colpatria,
  davivienda,
  avvillas,
  bancamia,
  bancoAgrario,
  bancoCajaSocial,
  bancoCoopCentral,
  credifinanciera,
  bancodeOccidente,
  falabella,
  finandia,
  itau,
  pichincha,
  bpc,
  bancoW,
  bancoOmeva,
  bancoldex,
];

const String genero = 'assets/icons/genero.svg';
//Mensajes de error de login
final RegExp emailValidator =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9.]+\.[a-zA-Z]+");
//email
const String emailNull = "Por favor ingrese su correo";
const String emailError = "Ingrese un correo válido";
//password
const String passNull = "Por favor ingrese su contraseña";
const String passError = "La Contraseña debe tener al\nal menos 8 caracteres";
//repeticiones y coincidencias
const String machError = "Su contraseña no coincide";
const String reNull = "Re-ingrese su contraseña";

//Mensajes de completar perfil Perfil
const String nameNull = "Por favor ingresa tu nombre";
const String apeNull = "Por favor ingresa tu apellido";
const String phoneError = "Por favor ingresa tu número de teléfono";
const String addressError = "Por favor ingresa tu dirección";
const String cityError = "Por favor ingresa tu Ciudad";
const String codeError = "Por favor ingresa el Código de quien te refirío\nSi no tienes pon JoieDriver";
const String carMarkError = "Por favor ingresa la Marca de tu vehículo";
const String carModelError = "Por favor ingresa el modelo de tu vehículo";
const String carPlacaError = "Por favor ingresa la placa de tu vehículo";
const String nickNameError = "Por favor ingresa el nombre de usuario";
const String nickNameErrorMach = "Este usuario ya existe";

//Temas fijos de titulos, headings que se usarán siempre

final estiloShare = BoxDecoration(
  gradient: jGSec,
  borderRadius: BorderRadius.circular(50),
);

final heading1 = TextStyle(
  fontSize: getPropertieScreenWidth(15),
  fontWeight: FontWeight.w400,
  color: jtextColor,
);
final title1 = TextStyle(
  fontSize: getPropertieScreenWidth(15),
  fontWeight: FontWeight.bold,
  color: jtextColor,
);
final title2 = TextStyle(
  fontSize: getPropertieScreenWidth(25),
  fontWeight: FontWeight.bold,
  color: jBase,
);

final heading2 = TextStyle(
  fontSize: getPropertieScreenWidth(18),
  fontWeight: FontWeight.bold,
  color: jSec,
);

const listStyle =
TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: blue);

final shareDecoration = BoxDecoration(
  color: Colors.grey[100],
  borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(24),
    topRight: Radius.circular(24),
  ),
);

// para pedido
double totalCliente = 50.00;
double total = 50.00;
Color selelct = Colors.black87;
Color selelct1 = Colors.white;
Color selelct2 = Colors.white;
Color selelct3 = Colors.white;
Color selelct4 = Colors.white;
Color selelct5 = Colors.white;

//Variables para los formularios

String? email;
String? password;
String? conformPassword;
bool remerber = false;
String? firstName;
String? secondName;
String? lastName;
String? last2Name;
String? phoneNumber;
String? address;
String? city;
String? carModel;
String? carMark;
String? carPlaca;
String? nickName;
String? codeRef;
final List<String> errors = [];

final formKey = GlobalKey<FormState>();
final emailController = TextEditingController();
final passwordController = TextEditingController();
final TextEditingController controllerTextCedula = TextEditingController();
final TextEditingController controllerTextName = TextEditingController();
final TextEditingController controllerTextNumber = TextEditingController();
final codeProvider = ChangeNotifierProvider((ref) => CodeNotify());
final emailProvider = ChangeNotifierProvider((ref) => EmailNotify());
bool mensajeRequest = false;

bool isSwitched = false;

GlobalKey<ScaffoldState>? scaffoldKey;


String state = "Desconectado";

Color colorin = Colors.white;

Future<bool?> showToast(String message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: blue,
      textColor: Colors.white,
      fontSize: 16.0
  );
}