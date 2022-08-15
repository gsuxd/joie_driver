import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:joiedriver/singletons/user_data.dart';
import 'choose/choose.dart';
import 'home/home.dart';
import 'home_user/home.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  //late VideoPlayerController _controller;
  bool isLoading = true;
  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      await registerSingleton();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            if (FirebaseAuth.instance.currentUser != null) {
              if (GetIt.I.get<UserData>().type != "users") {
                return const HomeScreenUser();
              }
              return const HomeScreen();
            }
            return const ChooseScreen();
          },
        ),
      );
      setState(() {
        // _controller = VideoPlayerController.asset("assets/videos/video.mp4")
        //   ..initialize().then((_) {
        //     _controller.play();
        //     _controller.setLooping(true);
        //     setState(() {});
        //   });
        isLoading = false;
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
