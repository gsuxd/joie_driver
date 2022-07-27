import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:joiedriver/singletons/user_data.dart';
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
                  GetIt.I.get<UserData>().name,
                  style: title1,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Text(
              GetIt.I.get<UserData>().lastName,
              style: heading1,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ],
    );
  }
}
