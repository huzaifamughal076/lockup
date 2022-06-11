import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'OnboardingScreen.dart';


class SplashScreens extends StatefulWidget {
  const SplashScreens({Key? key}) : super(key: key);

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Lock Up",
      home: AnimatedSplashScreen(
        duration: 3000,
        splash:
        Image.asset('assets/images/lock.png'), nextScreen: OnboardingScreen(),
      ),
    );
  }


}