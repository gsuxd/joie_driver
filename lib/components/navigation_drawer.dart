import 'package:flutter/material.dart';
import '../register_login_chofer/conts.dart';
import '../register_login_chofer/size_config.dart';
import 'default_button.dart';
import 'profile_card.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(children: [
          SizedBox(
            height: getPropertieScreenHeight(12),
          ),
          const ProfileCard(),
          SizedBox(
            height: getPropertieScreenHeight(12),
          ),
          const Divider(),
          SizedBox(
            height: getPropertieScreenHeight(12),
          ),
          itemList(route: () {}, text: 'Comparte y gana', icon: Icons.share),
          SizedBox(
            height: getPropertieScreenHeight(20),
          ),
          ButtonDef(text: "Cerrar Cesión", press: () {}),
        ]),
      ),
    );
  }

  GestureDetector itemList({
    required String text,
    required Function() route,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: route,
      child: Row(
        children: [
          SizedBox(
            width: getPropertieScreenWidth(12),
          ),
          Text(
            text,
            style: title1,
          ),
          SizedBox(
            width: getPropertieScreenWidth(22),
          ),
          Icon(
            icon,
            color: jBase,
          ),
        ],
      ),
    );
  }
}
