import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joiedriver/blocs/markers/markers_bloc.dart';
import 'package:joiedriver/blocs/position/position_bloc.dart';
import 'package:joiedriver/blocs/user/user_bloc.dart';
import 'package:joiedriver/home/home.dart';
import 'package:joiedriver/home_user/home.dart';
import 'package:joiedriver/loadingScreen.dart';
import 'package:joiedriver/register_login_chofer/theme.dart';
import 'package:joiedriver/register_login_user/sign_in/log_in.dart';
import 'blocs/carrera/carrera_bloc.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(ProviderScope(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserBloc()..add(LoadUserEvent()),
          ),
          BlocProvider(
            create: (context) => PositionBloc(),
          ),
          BlocProvider(
            create: (context) => MarkersBloc(),
          ),
          BlocProvider(
            create: (context) => CarreraBloc(),
          ),
        ],
        child: const MyApp(),
      ),
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'Conductores',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Montserrat",
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Color(0xFF005EA8),
            ),
            titleTextStyle: TextStyle(
              color: Color(0xFF005EA8),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
            )),
        inputDecorationTheme: inputDecorationTheme(),
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Color.fromARGB(255, 6, 38, 63)),
          bodyText2: TextStyle(color: Color.fromARGB(255, 6, 38, 63)),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserNotLogged) {
          return const LognInScreenUser();
        }
        if (state is UserLogged) {
          switch (state.user.type) {
            case "chofer":
              return const HomeScreen();
            default:
              return const HomeScreenUser();
          }
        }
        if (state is UserLoading) {
          return const LoadingScreen();
        }

        return const Scaffold(
          body: Center(
            child: Text("Error de estado, porfavor reinicia la aplicación"),
          ),
        );
      },
    );
  }
}
