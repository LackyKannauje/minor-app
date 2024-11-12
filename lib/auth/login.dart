import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:minor_app/auth/forget_password.dart';
import 'package:minor_app/const/config.dart';

import 'package:minor_app/const/mybutton.dart';
import 'package:minor_app/bottom-navbar/navigation.dart';
import 'package:minor_app/auth/signup.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../const/ui_helper.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  bool pcheck = true;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  Future<void> initSharedPref() async {
    prefs = await _prefs;
  }

  Future<void> loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        'email': emailController.text,
        'password': passwordController.text
      };
      var response = await http.post(Uri.parse('$apiBaseUrl/api/user/login'),
          body: jsonEncode(regBody),
          headers: {'content-type': 'application/json'});

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyBottomNavigationBar(token: myToken)));
      } else {
        print('Something went wrong');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Sign In Text
            const Text(
              "Sign In",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
            //spacing using a sizedbox
            const SizedBox(
              height: 50,
            ),
            //Username Textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: boxes(
                txt: 'Email or Phone number',
                iconData: Icons.mail,
                obscuretext: false,
                controller: emailController,
              ),
            ),
            //spacing using a sizedbox
            SizedBox(
              height: 20,
            ),
            //Password Textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: passwordController,
                obscureText: pcheck,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          pcheck = !pcheck;
                        });
                      },
                      icon: Icon(Icons.remove_red_eye)),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            //spacing using a sizedbox
            SizedBox(
              height: 20,
            ),
            //Forgot password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPassword(),
                        ),
                      );
                    },
                    child: Text("Forgot Password?"),
                  ),
                ],
              ),
            ),
            //spacing using a sizedbox
            SizedBox(
              height: 20,
            ),
            //Sign In button
            MyButton(
              onTap: loginUser,
              btnname: "Sign In",
            ),
            //spacing using a sizedbox
            SizedBox(
              height: 40,
            ),
            //continue with
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Or continue with",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            //spacing using a sizedbox
            SizedBox(
              height: 20,
            ),
            //Google and Apple images
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    "assets/google.jpg",
                    height: 50,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    "assets/apple.jpg",
                    height: 50,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 30,
            ),
            //Register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dont have an account?"),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Homepage {}
