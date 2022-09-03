import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joiedriver/register_login_emprendedor/app_screens/ganancias/body.dart';
import 'package:joiedriver/register_login_emprendedor/app_screens/menu_drawable.dart';
import '../../sign_in/log_in.dart';
import '../appbar.dart';
import '../share/share.dart';
import 'package:local_auth/local_auth.dart';


class CodeNotifyE extends ChangeNotifier {

  String _code = "";

  String get code => _code;

  void setCode(String view,) {
    _code = view;
    notifyListeners();
  }
}
final codeProviderE = ChangeNotifierProvider((ref) => CodeNotifyE());

class Ganancias extends ConsumerStatefulWidget {
  const Ganancias({Key? key}) : super(key: key);
  @override
  _Body createState() => _Body();
}

class _Body extends ConsumerState<Ganancias> {
  @override
  void initState()  {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final code = ref.read(codeProviderE);
    String codeI = await encryptedSharedPreferences.getString('code');
    code.setCode(codeI);
  }

  EncryptedSharedPreferences encryptedSharedPreferences =
  EncryptedSharedPreferences();
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, child) {
          CodeNotifyE  code = ref.watch(codeProviderE);
          return   Scaffold(
            appBar: appBarEmprendedor(title: 'CDE: ${code.code}', leading: leading(), accion: [ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  const ShareEmprendedor()
                      ));
                },
                style: ElevatedButton.styleFrom(primary: Colors.transparent, elevation: 0, shadowColor: Colors.transparent),

                child: SvgPicture.asset("assets/images/share.svg", height: 36, color: Colors.white,))]),
              drawer: menuEmprendedor(context: context),
              body: const BodyGanancias(),
          );
        }
    );
  }

  Builder leading(){
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 36,),
          onPressed: () { Scaffold.of(context).openDrawer(); },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    );
  }

}