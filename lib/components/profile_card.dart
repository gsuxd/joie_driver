import 'package:flutter/material.dart';
import '../register_login_chofer/conts.dart';
import '../register_login_chofer/size_config.dart';


class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getPropertieScreenWidth(12),
        ),
        CircleAvatar(
          minRadius: getPropertieScreenWidth(25),
        ),
        SizedBox(
          width: getPropertieScreenWidth(15),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Hola',
                  style: title1,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  width: getPropertieScreenWidth(5),
                ),
                Text(
                  'User',
                  style: title1,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Text(
              'Nombre',
              style: heading1,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ],
    );
  }
}
