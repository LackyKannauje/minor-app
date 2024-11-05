import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minor_app/auth/login.dart';
import 'package:minor_app/const/mybutton.dart';
import '../const/ui_helper.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool pcheck = true;

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();

  Future<void> createAccount() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        'fullName': nameController.text,
        'email': emailController.text,
        'password': passwordController.text
      };
      var response = await http.post(
          Uri.parse('http://192.168.215.72:8000/user/signup'),
          body: jsonEncode(regBody),
          headers: {'content-type': 'application/json'});

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
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
            //Login Text
            Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: boxes(
                txt: 'Full Name',
                iconData: Icons.edit_square,
                obscuretext: false,
                controller: nameController,
              ),
            ),
            SizedBox(
              height: 20,
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
            SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 20,
            ),
            //Sign In button
            MyButton(
              onTap: createAccount,
              btnname: "Sign Up",
            ),
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
            SizedBox(
              height: 20,
            ),

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
                    "apple.jpg",
                    height: 50,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
