import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/register_login_chofer/helpers/recoverProgress.dart';
import 'package:joiedriver/register_login_chofer/theme.dart';
import 'package:joiedriver/register_login_emprendedor/helpers/recoverProgress.dart';
import 'package:joiedriver/register_login_user/helpers/recoverProgress.dart';
import 'package:joiedriver/register_login_user/sign_in/log_in.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'blocs/carrera/carrera_bloc.dart';
import 'blocs/markers/markers_bloc.dart';
import 'blocs/position/position_bloc.dart';
import 'blocs/user/user_bloc.dart';
import 'colors.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

import 'home/home.dart';
import 'home_user/home.dart';
import 'loadingScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }
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
  //runApp(const MyApp());
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
      darkTheme: ThemeData(
        //Se indica que el tema tiene un brillo oscuro
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'JoieDriver',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  EncryptedSharedPreferences encryptedSharedPreferences =
      EncryptedSharedPreferences();
  late VideoPlayerController _controller;
  late double longitude;
  late double latitude;

  void _resume(context) async {
    final _prefs = await EncryptedSharedPreferences().getInstance();
    if (_prefs.getString("userType") != null) {
      _prefs.setBool("isFailLogin", true);
      switch (_prefs.getString("userType")) {
        case "chofer":
          recoverProgressChofer(context);
          break;
        case "emprendedor":
          recoverProgressEmprendedor(context);
          break;
        default:
          recoverProgressPasajero(context);
      }
    }
  }

  @override
  void initState() {
    _resume(context);
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/video.mp4")
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
        fetchUserOrder(context, 0.0, 0.0);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      body: Center(
        child: FittedBox(
          fit: BoxFit.fill,
          child: SizedBox(
            width: _controller.value.size.width,
            height: _controller.value.size.height,
            child: VideoPlayer(_controller),
          ),
        ),
      ),
    );
  }

  Future<void> permiso() async {
    if (await Permission.location.request().isGranted) {
      // Permiso concedido
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void fetchUserOrder(BuildContext context, double longitude, double latitude) {
    // Imagine that this function is fetching user info from another service or database.
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => BlocBuilder<UserBloc, UserState>(
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
                        child: Text(
                            "Error de estado, porfavor reinicia la aplicación"),
                      ),
                    );
                  },
                )),
        (route) => false);
  }
}
