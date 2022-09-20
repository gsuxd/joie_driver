import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import "package:flutter/material.dart";
import '../../conts.dart';
import '../appbar.dart';
import 'package:share_plus/share_plus.dart';

class ShareEmprendedor extends StatefulWidget {
  const ShareEmprendedor({Key? key}) : super(key: key);

  @override
  createState() => _ShareEmprendedor();
}

class _ShareEmprendedor extends State<ShareEmprendedor> {

  @override
  void initState()  {
    super.initState();
    getData();
  }

  Future<void> getData() async {

    codeI = await encryptedSharedPreferences.getString('code');
  }

  String codeI = "";

  EncryptedSharedPreferences encryptedSharedPreferences =
  EncryptedSharedPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarEmprendedor(
            accion: [], leading: back(context), title: 'Compartir App'),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'Invita a parceritos a sumarse a JoieDriver',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Por una carrera más justa para todos',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff0087f5),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Image.asset('assets/images/recomendar-aplicacion.jpg'),
              const SizedBox(height: 20),
              const SizedBox(
                height: 50,
                width: 300,
                child: ShareButton(),
              ),
              const SizedBox(height: 20),
               SizedBox(
                height: 50,
                width: 300,
                child: referir(),
              ),
            ],
          ),
        ),

    );
  }

  ElevatedButton referir(){
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            side: const BorderSide(width: 1.0, color: Color(0xff0087f5)),
            primary: Colors.white,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        onPressed: () {
          Share.share('Registrate con mi código de referido y gana,\n $codeI \n https://play.google.com/store/apps/details?id=com.ciddras.joiedriver', subject: 'Instala JoieDriver');
        },
        child: const Text(
          'Compartir Código',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xff0087f5),
          ),
          textAlign: TextAlign.center,
        ));
  }

}


class ShareButton extends StatelessWidget {
  const ShareButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            side: const BorderSide(width: 1.0, color: Colors.white),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        onPressed: () {
          Share.share('Hey Instala Joidriver y llega a tu destino! https://play.google.com/store/apps/details?id=com.ciddras.joiedriver', subject: 'Instala JoieDriver');
        },
        child: const Text(
          'Compartir a un parcero',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ));
  }
}
