import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joiedriver/loadingScreen.dart';
import 'package:joiedriver/register_login_chofer/theme.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return const LoadingScreen();
  }
}
