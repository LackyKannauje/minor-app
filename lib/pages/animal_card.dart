// import 'package:flutter/material.dart';
// import 'package:animal_rescue_application/api/animal_api.dart';
// import '../models/animal.dart';
// import 'screens/add_animal_form.dart';

// class AnimalListPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Animal Rescue Details'),
//       ),
//       body: FutureBuilder<List<Animal>>(
//         future: fetchAnimals(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No animals found'));
//           } else {
//             List<Animal> animals = snapshot.data!;

//             return ListView.builder(
//               itemCount: animals.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   margin: EdgeInsets.all(10),
//                   elevation: 5,
//                   child: ListTile(
//                     contentPadding: EdgeInsets.all(15),
//                     title: Text(
//                       animals[index].category,
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(animals[index].description),
//                     leading: Icon(Icons.pets, size: 40),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddAnimalForm()),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:animal_rescue_application/const/const.dart';
import 'package:animal_rescue_application/const/globles.dart';
import 'package:animal_rescue_application/pages/screens/animal_detail.dart';
import 'package:animal_rescue_application/pages/screens/camera.dart';

class AnimalListPage extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchAnimals() async {
    if (globalToken == null) {
      return [];
    }
    final id = JwtDecoder.decode(globalToken!)['user']?['id'];
    final url =
        Uri.parse('https://minor-backend-xi.vercel.app/api/animal/userId/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load animals: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Submitted Reports',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor, // Using primary color for the app bar
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchAnimals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No animals found'));
          } else {
            List<Map<String, dynamic>> animals = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                itemCount: animals.length,
                itemBuilder: (context, index) {
                  var animal = animals[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the details page when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AnimalDetailPage(animal: animal),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: thirdColor, // Light background for the card
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: animal['image'] != null
                                  ? Image.network(
                                      animal['image'],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.pets,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    animal['category'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors
                                          .black87, // Dark text for contrast
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Status: ${animal['status']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: _getStatusColor(animal['status']),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CameraPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: primaryColor, // Using primary color for the button
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'rescued':
        return Colors.green;
      case 'adopted':
        return Colors.blue;
      case 'found':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
