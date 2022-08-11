import 'package:flutter/material.dart';

Container btn(String text, funct) {
  return Container(
    margin: const EdgeInsets.only(left: 10, right: 10),
    child: ElevatedButton(
      onPressed: funct,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            // Change your radius here
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
      child: SizedBox(
        height: 60,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    ),
  );
}

Widget formCode(controller) {
  return Container(
    margin: const EdgeInsets.only(left: 10, right: 10),
    child: TextFormField(
      style: const TextStyle(height: 1.0, fontSize: 20.0),
      cursorHeight: 20.0,
      maxLength: 6,
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
    ),
  );
}
