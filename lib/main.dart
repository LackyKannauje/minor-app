import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:animal_rescue_application/const/globles.dart';
import 'package:http/http.dart' as http;
import 'package:animal_rescue_application/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// flutter build apk --target-platform android-arm --analyze-size
// flutter build apk --target-platform android-arm64 --analyze-size
// flutter build apk --target-platform android-x64 --analyze-size

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  globalToken = prefs.getString('token');
  String? role;
  if (globalToken != null) {
    final isExpired = JwtDecoder.isExpired(globalToken!);
    if (isExpired) {
      prefs.remove('token');
      globalToken = null;
    }

    try {
      final id = JwtDecoder.decode(globalToken!)['user']['id'];
      final response = await http.get(
          Uri.parse('https://minor-backend-xi.vercel.app/api/user/$id/role'));
      if (response.statusCode == 200) {
        final jsonBody = response.body;
        print(jsonBody);
        final jsonDecoded = json.decode(jsonBody);
        role = jsonDecoded['role'];
        print(role);
      } else {
        print("Not 200 status");
      }
    } catch (e) {
      print(e);
    }
  }

  runApp(MyApp(role: role));
}

class MyApp extends StatelessWidget {
  final String? role;
  const MyApp({required this.role, super.key});

  @override
  Widget build(BuildContext context) {
    print(role);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(role: role),
    );
  }
}
