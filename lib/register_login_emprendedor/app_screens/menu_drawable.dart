import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joiedriver/register_login_emprendedor/app_screens/perfil/perfil_emprendedor.dart';
import 'package:joiedriver/register_login_emprendedor/app_screens/test_login.dart';
import '../../colors.dart';
import '../../main.dart';
import 'asistencia_tecnica/asistencia_tecnica.dart';
import 'asistencia_tecnica/list_asistencia.dart';
import 'banco/bancos_data.dart';
import 'change_password/change_password.dart';
import 'ganancias/ganancias.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';


Drawer menuEmprendedor({required BuildContext context}) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        Image.asset("assets/images/banner_header.png", fit: BoxFit.cover,),
        itemMenu(context: context, image: "ganancias.svg", title: "Ganancias", page: const Ganancias()),
        itemMenu(context: context, image: "perfil_menu.svg", title: "Perfil", page:  PerfilEmprendedor()),
        itemMenu(context: context, image: "cuenta_bancaria.svg", title: "Datos Bancarios", page: BancoEmprendedor()),
        itemMenu(context: context, image: "ajustes.svg", title: "Ajustes", page:  ChangePasswordScreen()),
        itemMenu(context: context, image: "asistencia_tecnica_menu.svg", title: "Asistencia Técnica", page: const ListAsisTecnicaEmprendedor()),
        cerrarSession(context: context, image: "cerrar_sesion.svg", title: "Cerrar Sesión", page: const MyHomePage(title: 'JoieDriver',)),
      ],
    ),
  );
}

ListTile itemMenu(
    {required BuildContext context,
    required String image,
    required String title,
    required  page}) {
  return ListTile(
    leading: SvgPicture.asset("assets/icons/"+image, height: 30, color: greyColor,),
    title: Text(title, style: textStyleGrey(),),
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  page
          ));
    },
  );
}

ListTile cerrarSession(
    {required BuildContext context,
      required String image,
      required String title,
      required  page}) {
  EncryptedSharedPreferences encryptedSharedPreferences = EncryptedSharedPreferences();
  return ListTile(
    leading: SvgPicture.asset("assets/icons/"+image, height: 30, color: greyColor,),
    title: Text(title, style: textStyleGrey(),),
    onTap: () {
      encryptedSharedPreferences.clear().then((bool success) {
        if (success) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>  page
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>  const Ganancias()
              ));
        }
      });
    },
  );
}

