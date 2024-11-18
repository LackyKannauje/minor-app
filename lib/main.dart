import 'package:flutter/material.dart';
import 'package:minor_app/auth/login.dart';
import 'package:minor_app/bottom-navbar/navigation.dart';
import 'package:minor_app/pages/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(token: prefs.getString('token')));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({@required this.token, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(token: token), // Pass token to SplashScreen
    );
  }
}
