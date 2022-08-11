import 'package:flutter/material.dart';
import '../../conts.dart';
import '../../size_config.dart';


class ButtonDef extends StatelessWidget {
  const ButtonDef({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: jBase,
        borderRadius: BorderRadius.circular(75),
      ),
      width: double.infinity,
      height: getPropertieScreenHeight(56),
      child: TextButton(
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: getPropertieScreenWidth(18)),
          )),
    );
  }
}