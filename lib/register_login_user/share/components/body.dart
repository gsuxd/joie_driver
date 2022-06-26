import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../components/states/states.dart';
import '../../conts.dart';
import '../../size_config.dart';

// class Body extends StatefulWidget {
//   Body({Key? key}) : super(key: key);
//
//   @override
//   State<Body> createState() => _BodyState();
// }

class ScreenNotify extends ChangeNotifier {

  String _text = "Invita a un parcero";
  Color _color = Colors.white;

  String get text => _text;
  Color get color => _color;

  void setScreen(String text, Color color) {
    _text = text;
    _color = color;
    notifyListeners();
  }
}


final screenProvider = ChangeNotifierProvider((ref) => ScreenNotify());

class Body extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    CodeNotify  code = watch.watch(codeProvider);
    ScreenNotify  screen = watch.watch(screenProvider);
    return SafeArea(
      minimum: EdgeInsets.all(getPropertieScreenWidth(10)),
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 15,
              right: 35,
            ),
            margin: EdgeInsets.only(
              top: 12,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Gana hasta \$ 5000',
                  style: title2,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 25,
              bottom: 25,
            ),
            child: SizedBox(
              height: getPropertieScreenHeight(100),
              child: Text(
                "Gane 5000 pesos por cada recarga de 50.000 pesos que hagan sus referidos permanentemente",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: jtextColor,
                  fontSize: getPropertieScreenWidth(18),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            //Para que esta imagen funcione tiene que colorcar en el const.dart
            //la siguiente linea const String share = 'assets/icons/compartir.svg';
            //y poner el earchivo en ese asset
            child: SvgPicture.asset(
              share,
              width: getPropertieScreenWidth(325),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: getPropertieScreenWidth(300),
            height: getPropertieScreenHeight(80),
            padding: EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 5,
            ),
            margin: EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            decoration: estiloShare,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  code.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Comparte tu código de invitación',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: getPropertieScreenHeight(15),
          ),
          Container(
            decoration: BoxDecoration(
              color: screen.color,
              border: Border.all(
                color: jBase,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            child: GestureDetector(
                onTap: ()  async {
                  screen.setScreen("Copiado" ,Colors.transparent);
                  Clipboard.setData(new ClipboardData(text: code.value));
                  // if (await Vibration.hasAmplitudeControl()) {
                  // Vibration.vibrate(amplitude: 128, duration: 600);
                  // }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Codigo Copiado'),
                      // action: SnackBarAction(
                      //   label: 'Action',
                      //   onPressed: () {
                      //     // Code to execute.
                      //   },
                      // ),
                    ),
                  );
                },
                child: Text(
                  screen._text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: jBase,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
