import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:joiedriver/home_user/components/appBar.dart';
import '/components/navigation_drawer.dart';
import 'bloc/cars_bloc.dart';
import 'components/map_view_pasajeros.dart';

class HomeScreenUser extends StatefulWidget {
  static String routeName = '/home';

  const HomeScreenUser({Key? key}) : super(key: key);

  @override
  State<HomeScreenUser> createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {
  @override
  void initState() {
    context.read<PositionBloc>().add(
        GetPositionEvent((context.read<UserBloc>().state as UserLogged).user));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
      drawer: const NavigationDrawer(),
      body: BlocBuilder<PositionBloc, PositionState>(
        builder: (context, state) {
          if (state is PositionLoading || state is PositionInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PositionError) {
            return const Center(
              child: Text('Error'),
            );
          }
          return BlocProvider(
            create: (context) => CarsBloc()
              ..add(LoadNearCars((state as PositionObtained).location)),
            child: const MapViewPasajeros(),
          );
        },
      ),
    );
  }
}
