import 'package:flutter/material.dart';
import 'package:joiedriver/conts.dart';

class ButtonDefEmprendedor extends StatelessWidget {
  const ButtonDefEmprendedor({
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
      height: (56),
      child: TextButton(
          onPressed: press,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: (18)),
          )),
    );
  }
}
