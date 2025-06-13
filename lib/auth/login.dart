import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:animal_rescue_application/auth/forget_password.dart';
// import 'package:animal_rescue_application/const/globles.dart';
import 'package:animal_rescue_application/const/mybutton.dart';
import 'package:animal_rescue_application/bottom-navbar/navigation.dart';
import 'package:animal_rescue_application/auth/signup.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../const/ui_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool pcheck = true;
  bool isLoading = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;

  String? errorMessage;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  Future<void> initSharedPref() async {
    prefs = await _prefs;
  }

  Future<void> loginUser() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        errorMessage = "Please fill in all the fields.";
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      var regBody = {
        'email': emailController.text,
        'password': passwordController.text
      };
      var response = await http.post(
        Uri.parse('https://minor-backend-xi.vercel.app/api/user/login'),
        body: jsonEncode(regBody),
        headers: {'content-type': 'application/json'},
      );

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var myToken = jsonResponse['token'];
        await prefs.setString('token', myToken);
        String? role;
        try {
          final id = JwtDecoder.decode(myToken!)['user']['id'];
          final response = await http.get(Uri.parse(
              'https://minor-backend-xi.vercel.app/api/user/$id/role'));
          if (response.statusCode == 200) {
            final jsonBody = response.body;
            final jsonDecoded = jsonDecode(jsonBody);
            role = jsonDecoded['role'];
          } else {
            print("Not 200 status");
          }
        } catch (e) {
          print(e);
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyBottomNavigationBar(
              role: role,
            ),
          ),
        );
      } else if (response.statusCode == 400) {
        setState(() {
          errorMessage = jsonResponse['msg'] ?? "Invalid credentials.";
        });
      } else {
        setState(() {
          errorMessage = "An unexpected error occurred. Please try again.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Network error. Please check your connection.";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 50),
              // Email TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: boxes(
                  txt: 'Email or Phone number',
                  iconData: Icons.mail,
                  obscuretext: false,
                  controller: emailController,
                ),
              ),
              const SizedBox(height: 20),
              // Password TextField
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
                      icon: Icon(
                        pcheck ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Forgot password
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
                            builder: (context) => const ForgetPassword(),
                          ),
                        );
                      },
                      child: const Text("Forgot Password?"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Error message
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              // Sign In button
              isLoading
                  ? const CircularProgressIndicator()
                  : MyButton(
                      onTap: loginUser,
                      btnname: "Sign In",
                    ),
              const SizedBox(height: 40),
              // Or continue with
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
              const SizedBox(height: 20),
              // Google and Apple images
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
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
                  const SizedBox(width: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
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
              const SizedBox(height: 30),
              // Register link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
