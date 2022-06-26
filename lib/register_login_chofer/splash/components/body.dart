import 'package:flutter/material.dart';
import '../../conts.dart';
import '../../size_config.dart';

import '../../termin_y_condiciones/terminos_y_condiciones.dart';
import 'default_button.dart';
import 'splash_components.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int cP = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: SizedBox(
                width: double.infinity,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      cP = value;
                    });
                  },
                  itemCount: splashD.length,
                  itemBuilder: (context, index) => SplashElements(
                    //Aqui están los elementos de la pantalla en sí
                    image: splashD[index]["image"],
                    text: splashD[index]["text"],
                  ),
                )),
          ),
          //Aqui empiezan los botones
          Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getPropertieScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            splashD.length, (index) => buildDot(index: index))),
                    const Spacer(flex: 2),
                    ButtonDef(
                      press: () {
                        //Navigator.pushNamed(context, LognInScreen.routename);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TerminosCondiciones()));
                      },
                      text: "Empieza",
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  //Los contenedores animados debajo de las letras
  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: jDuration,
      margin: EdgeInsets.only(
        right: 6,
      ),
      height: 6,
      width: cP == index ? 30 : 18,
      decoration: BoxDecoration(
          color: cP == index ? jBase : jtextColorSec,
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
