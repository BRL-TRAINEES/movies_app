import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/screens/homescreen.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: AnimatedSplashScreen(
          splash: Lottie.asset(
              'assets/animation/Animation - 1729075318143.json',
              fit: BoxFit.cover),
          nextScreen: Homescreen(),
          duration: 3600,
          splashIconSize: double.infinity,
          backgroundColor: Color.fromRGBO(222, 219, 18, 0),
        ),
      ),
    );
  }
}
