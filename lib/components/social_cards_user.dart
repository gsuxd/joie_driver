import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:joiedriver/conts.dart';
import 'package:joiedriver/size_config.dart';

class SocialCardUser extends StatelessWidget {
  const SocialCardUser({
    Key? key,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String icon;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(getPropertieScreenWidth(12)),
        height: getPropertieScreenHeight(60),
        width: getPropertieScreenWidth(60),
        child: SvgPicture.asset(
          icon,
          color: jSec,
        ),
      ),
    );
  }
}
