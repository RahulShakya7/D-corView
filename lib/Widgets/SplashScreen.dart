import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Views/Login.dart';
import 'package:fyp/Views/MainPage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void navigateToNextScreen(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterSplashScreen.fadeIn(
          backgroundColor: Colors.white,
          onInit: () {
            debugPrint("On Init");
          },
          onEnd: () {
            debugPrint("On End");
            navigateToNextScreen(context); // Call the function here
          },
          childWidget: SizedBox(
            height: 200,
            width: 200,
            child: Image.asset("assets/logos/decorviewlogo.png"),
          ),
          onAnimationEnd: () {
            navigateToNextScreen(
                context); // Also call the function here to be sure
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const LinearProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
