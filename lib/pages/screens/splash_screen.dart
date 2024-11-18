import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minor_app/auth/login.dart';
import 'package:minor_app/bottom-navbar/navigation.dart';
import 'package:minor_app/pages/screens/onboarding.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  final String? token;

  const SplashScreen({Key? key, this.token}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 15), () async {
      // Check if onboarding is completed
      final prefs = await SharedPreferences.getInstance();
      bool isOnboardingCompleted =
          prefs.getBool('onboardingCompleted') ?? false;

      if (!isOnboardingCompleted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Onboarding()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => widget.token != null
                ? MyBottomNavigationBar(token: widget.token!)
                : LoginPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'background.png', // Path to your image
                // Ensures the image covers the entire screen
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText(
                        'ShelterSoul',
                        duration: Duration(seconds: 2),
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      ScaleAnimatedText(
                        'Adoption',
                        duration: Duration(seconds: 4),
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 50.0,
                          fontFamily: 'SourGummy',
                        ),
                      ),
                      ScaleAnimatedText(
                        'Animal Rescue',
                        duration: Duration(seconds: 4),
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 50.0,
                          fontFamily: 'SourGummy',
                        ),
                      ),
                      ScaleAnimatedText(
                        duration: Duration(seconds: 4),
                        'Give a Loving Home',
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 50.0,
                          fontFamily: 'SourGummy',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
