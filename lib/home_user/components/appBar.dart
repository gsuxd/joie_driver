import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:joiedriver/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Appbar extends StatefulWidget implements PreferredSizeWidget {
  const Appbar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  String cityName = "";

  void getCity(locationData) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData.latitude!, locationData.longitude!);
    var first = placemarks.first;
    setState(() {
      cityName = first.locality!;
    });
  }

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
            getCity(state.location);
          }
        },
        child: Row(
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(
                  (context.read<UserBloc>().state as UserLogged)
                      .user
                      .profilePicture),
            ),
            Row(children: [
              Container(
                margin: const EdgeInsets.only(left: 60, right: 10),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                ),
              ),
              Text(
                cityName,
                style: _baseStyle,
              ),
              Container(
                margin: const EdgeInsets.only(left: 40),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}
