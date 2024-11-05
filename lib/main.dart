import 'package:flutter/material.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:minor_app/auth/login.dart';
import 'package:minor_app/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(token: prefs.getString('token')));
}

class MyApp extends StatelessWidget {
  final token;
  const MyApp({@required this.token, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (token != null) ? MyBottomNavigationBar(token: token) : LoginPage(),
    );
  }
}
