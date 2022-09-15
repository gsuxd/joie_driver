import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:joiedriver/home/home.dart';
import 'package:local_auth/local_auth.dart';
import '../../register_login_emprendedor/conts.dart';
import 'ganancias/ganancias.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class AuthBiometric extends ConsumerStatefulWidget {
  const AuthBiometric({Key? key}) : super(key: key);
  @override
  _Body createState() => _Body();
}

class _Body extends ConsumerState<AuthBiometric> {
  EncryptedSharedPreferences encryptedSharedPreferences =
  EncryptedSharedPreferences();
  @override
  void initState()  {
    super.initState();
    //huellaAuth();
    irAprincipal();
  }

  Future<void> irAprincipal() async {
    String typeUser = await encryptedSharedPreferences.getString('typeuser');
    String codeLogin = await encryptedSharedPreferences.getString('code');
    if(typeUser == "emprendedor"){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  const Ganancias()));
    }else{
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>   HomeScreen(codeLogin)));
    }
  }

  Future huellaAuth() async{
    final LocalAuthentication auth = LocalAuthentication();
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    if(canAuthenticate){
      try {
        final bool didAuthenticate = await auth.authenticate(

            localizedReason: 'Autentíquese para mostrar su cuenta',
            authMessages: const [

              IOSAuthMessages(
                cancelButton: 'No Graciass',
              ),

              AndroidAuthMessages(
                signInTitle: 'Se requiere autenticación biométrica',
                cancelButton: 'Cancelar',
              ),
            ],
            options: const AuthenticationOptions(
              biometricOnly: true,
            ));
        if(!didAuthenticate){
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>  const LognInScreenEmprendedor()));
        }else{
          String typeUser = await encryptedSharedPreferences.getString('typeuser');
          String codeLogin = await encryptedSharedPreferences.getString('code');
          if(typeUser == "emprendedor"){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  const Ganancias()));
          }else{
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>   HomeScreen(codeLogin)));
          }

        }
      } on PlatformException catch (e) {
        showToast(
            "Tu dispositivo no Tiene habailitada la Autenticación Biometrica"
        );
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>  const LognInScreenEmprendedor()));
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, child) {
          CodeNotifyE  code = ref.watch(codeProviderE);
          return    const Scaffold(
            body: Center(
              // child: IconButton(
              //     onPressed: huellaAuth,
              //     icon: const Icon(Icons.fingerprint_rounded), color: jBase, iconSize: 56,),
            ),
          );
        }
    );
  }

}