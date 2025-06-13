// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:animal_rescue_application/auth/login.dart';
// import 'package:animal_rescue_application/const/config.dart';
// import 'package:animal_rescue_application/const/mybutton.dart';
// import '../const/ui_helper.dart';
// import 'package:http/http.dart' as http;

// class SignupPage extends StatefulWidget {
//   SignupPage({super.key});

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   bool pcheck = true;

//   final emailController = TextEditingController();

//   final passwordController = TextEditingController();

//   final nameController = TextEditingController();

//   Future<void> createAccount() async {
//     if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
//       var regBody = {
//         'fullName': nameController.text,
//         'email': emailController.text,
//         'password': passwordController.text
//       };
//       var response = await http.post(Uri.parse('https://minor-backend-xi.vercel.app/api/user/signup'),
//           body: jsonEncode(regBody),
//           headers: {'content-type': 'application/json'});

//       var jsonResponse = jsonDecode(response.body);
//       if (jsonResponse['status']) {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => LoginPage()));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             //Login Text
//             Text(
//               "Sign Up",
//               style: TextStyle(
//                 fontSize: 40,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25.0),
//               child: boxes(
//                 txt: 'Full Name',
//                 iconData: Icons.edit_square,
//                 obscuretext: false,
//                 controller: nameController,
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             //Username Textfield
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25.0),
//               child: boxes(
//                 txt: 'Email or Phone number',
//                 iconData: Icons.mail,
//                 obscuretext: false,
//                 controller: emailController,
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             //Password Textfield
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25.0),
//               child: TextField(
//                 controller: passwordController,
//                 obscureText: pcheck,
//                 decoration: InputDecoration(
//                   suffixIcon: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           pcheck = !pcheck;
//                         });
//                       },
//                       icon: Icon(Icons.remove_red_eye)),
//                   labelText: "Password",
//                   labelStyle: TextStyle(color: Colors.grey),
//                   enabledBorder: const OutlineInputBorder(
//                     borderSide: const BorderSide(
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),

//             SizedBox(
//               height: 20,
//             ),
//             //Sign In button
//             MyButton(
//               onTap: createAccount,
//               btnname: "Sign Up",
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             //continue with
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Divider(
//                       thickness: 0.5,
//                       color: Colors.grey.shade400,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Text(
//                       "Or continue with",
//                       style: TextStyle(color: Colors.grey.shade700),
//                     ),
//                   ),
//                   Expanded(
//                     child: Divider(
//                       thickness: 0.5,
//                       color: Colors.grey.shade400,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.white),
//                     borderRadius: BorderRadius.circular(16),
//                     color: Colors.white,
//                   ),
//                   child: Image.asset(
//                     "assets/google.jpg",
//                     height: 50,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.white),
//                     borderRadius: BorderRadius.circular(16),
//                     color: Colors.white,
//                   ),
//                   child: Image.asset(
//                     "assets/apple.jpg",
//                     height: 50,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:animal_rescue_application/auth/login.dart';
import 'package:animal_rescue_application/const/mybutton.dart';
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

  final _formKey = GlobalKey<FormState>();
  String? errorMessage;

  Future<void> createAccount() async {
    if (_formKey.currentState!.validate()) {
      var regBody = {
        'fullName': nameController.text,
        'email': emailController.text,
        'password': passwordController.text
      };

      try {
        var response = await http.post(
          Uri.parse('https://minor-backend-xi.vercel.app/api/user/signup'),
          body: jsonEncode(regBody),
          headers: {'content-type': 'application/json'},
        );

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        } else if (response.statusCode == 400) {
          if (jsonResponse.containsKey('msg')) {
            setState(() {
              errorMessage = jsonResponse['msg'] ?? 'Something went wrong!';
            });
          } else if (jsonResponse.containsKey('errors')) {
            List<dynamic> errors = jsonResponse['errors'];
            String combinedErrors = errors
                .map((error) => error['msg'])
                .join('\n'); // Combine error messages
            setState(() {
              errorMessage = combinedErrors;
            });
          }
        } else {
          setState(() {
            errorMessage = "Something went wrong. Please try again.";
          });
        }
      } catch (error) {
        setState(() {
          errorMessage = "Network error. Please check your connection.";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 50),

                // Full Name Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.edit_square),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Full Name is required";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),

                // Email Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),

                // Password Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: pcheck,
                    decoration: InputDecoration(
                      labelText: 'Password',
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
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),

                // Error Message Display
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                SizedBox(height: 20),

                // Sign Up Button
                MyButton(
                  onTap: createAccount,
                  btnname: "Sign Up",
                ),
                SizedBox(height: 40),

                // Continue with Divider
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
                SizedBox(height: 20),

                // Social Media Sign-In
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
                    SizedBox(width: 20),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
