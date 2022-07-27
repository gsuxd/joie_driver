import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joiedriver/home_user/home.dart';
import 'package:joiedriver/perfil_chofer.dart';
import 'package:joiedriver/perfil_usuario.dart';
import 'package:joiedriver/register_login_chofer/splash/splash_screen.dart';
import 'package:joiedriver/register_login_chofer/theme.dart';
import 'package:joiedriver/singletons/user_data.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'choose/choose.dart';
import 'colors.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event != null) {
        await registerSingleton();
      } else {
        if (GetIt.I.isRegistered<UserData>()) {
          GetIt.I.unregister<UserData>();
        }
      }
    });
    runApp(const ProviderScope(
      child: MyApp(),
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
  late VideoPlayerController _controller;
  late double longitude;
  late double latitude;

  Future<void> _registerData() async {}

  @override
  void initState() {
    super.initState();
    _registerData();
    //goPrincipalMenu(context);
    // Pointing the video controller to our local asset.
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

  // goPrincipalMenu (BuildContext context) async {
  //   Future<Position> coord =  _determinePosition();
  //   double longitude = await coord.then((value) => value.longitude);
  //   double latitude = await coord.then((value) => value.latitude);
  //   //fetchUserOrder(context, longitude, latitude);
  // }

  Future<void> permiso() async {
    if (await Permission.location.request().isGranted) {
      // Permiso concedido
    }
  }

  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  // }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> fetchUserOrder(
      BuildContext context, double longitude, double latitude) {
    // Imagine that this function is fetching user info from another service or database.
    return Future.delayed(const Duration(seconds: 7), () {
      _controller.dispose();
      Navigator.push(context, MaterialPageRoute(
          //builder: (context) => MapaMenu(longitude: longitude, latitude: latitude,))));
          //builder: (context) => SplashScreen()
          builder: (context) {
        if (FirebaseAuth.instance.currentUser != null) {
          if (GetIt.I.get<UserData>().type != "users") {
            return const PerfilUsuario();
          }
          return PerfilChofer();
        }
        return const ChooseScreen();
      }));
    });
  }
}
