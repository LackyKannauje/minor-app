import 'dart:convert';

import 'package:animal_rescue_application/admin/pages/animal_detail_page.dart';
import 'package:animal_rescue_application/auth/login.dart';
import 'package:animal_rescue_application/const/globles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // final List<Map<String, dynamic>> sampleData = [
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List<dynamic> adoptionData = [];

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> logout() async {
    final pref = await _prefs;
    pref.remove('token');
    globalToken = null;
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://minor-backend-xi.vercel.app/api/animal/case/rescue'));
      final jsonBody = response.body;
      final jsonResponse = json.decode(jsonBody);
      setState(() {
        print(jsonResponse);
        adoptionData = jsonResponse;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rescue Cases',
          style: TextStyle(color: Colors.white), // White text color
        ),
        actions: [
          IconButton(
              onPressed: () {
                logout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(Icons.logout))
        ],
        backgroundColor: Colors.pink,
        iconTheme: const IconThemeData(
            color: Colors.white), // Ensures icons are white as well
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns for cards
            crossAxisSpacing: 16, // Space between columns
            mainAxisSpacing: 16, // Space between rows
            childAspectRatio: 0.8, // Aspect ratio for each card
          ),
          itemCount: adoptionData.length,
          itemBuilder: (context, index) {
            final data = adoptionData[index];
            return Card(
              elevation: 8, // Shadow for the floating effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(data: data),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(data['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.3),
                                  Colors.black.withOpacity(0.3),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['category'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Status: ${data['status']}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
