import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:joiedriver/colors.dart';
import 'package:joiedriver/helpers/get_city.dart';

class Appbar extends StatefulWidget implements PreferredSizeWidget {
  const Appbar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  String cityName = "";

  final TextStyle _baseStyle = const TextStyle(
      color: Colors.white,
      fontFamily: "Monserrat",
      fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: blue,
      automaticallyImplyLeading: false,
      actions: <Widget>[Container()],
      title: BlocListener<PositionBloc, PositionState>(
        listener: (context, state) {
          if (state is PositionObtained) {
            getCity(state.location).then((value) => setState(() {
                  cityName = value;
                }));
          }
        },
        child: Row(
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLogged) {
                  return CircleAvatar(
                      foregroundImage: NetworkImage(
                    state.user.profilePicture,
                  ));
                }
                return const CircularProgressIndicator();
              },
            ),
            Container(
              width: 240,
              margin: const EdgeInsets.only(left: 78),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                        ),
                        Text(
                          cityName,
                          style: _baseStyle,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
