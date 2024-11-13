// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:minor_app/const/config.dart';
// import 'package:minor_app/models/animal.dart';

// Future<List<Animal>> fetchAnimals() async {
//   final url = Uri.parse('$apiBaseUrl/api/animal');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     List<dynamic> data = json.decode(response.body);
//     return data.map((item) => Animal.fromJson(item)).toList();
//   } else {
//     throw Exception('Failed to load animals');
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:minor_app/const/config.dart';
import 'package:minor_app/models/animal.dart';

Future<List<Animal>> fetchAnimals() async {
  final url = Uri.parse('$apiBaseUrl/api/animal');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data
        .map((item) => Animal.fromJson(item as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Failed to load animals: ${response.statusCode}');
  }
}
