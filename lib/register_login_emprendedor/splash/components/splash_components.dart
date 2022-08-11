import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../size_config.dart';

class SplashElements extends StatelessWidget {
  const SplashElements({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);
  final String image, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(
          flex: 3,
        ),
        SvgPicture.asset(
          image,
          height: getPropertieScreenHeight(265),
        ),
        const Spacer(
          flex: 2,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: getPropertieScreenWidth(20),
              fontWeight: FontWeight.w300),
          textAlign: TextAlign.center,
        ),
        const Spacer()
      ],
    );
  }
}
