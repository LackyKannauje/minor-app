import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddAnimalForm extends StatefulWidget {
  @override
  _AddAnimalFormState createState() => _AddAnimalFormState();
}

class _AddAnimalFormState extends State<AddAnimalForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  String status = 'available for adoption';

  Future<void> submitAnimalDetails() async {
    final name = nameController.text;
    final description = descriptionController.text;
    final location = locationController.text;
    final contact = contactController.text;

    final url = Uri.parse('http://localhost:8000/api/animal/add');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'description': description,
        'status': status,
        'location': location,
        'contact': contact,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Animal added successfully')));
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to add animal')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Animal for Adoption/Rescue')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Animal Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: contactController,
              decoration: InputDecoration(labelText: 'Contact Info'),
            ),
            DropdownButton<String>(
              value: status,
              onChanged: (newStatus) {
                setState(() {
                  status = newStatus!;
                });
              },
              items: [
                DropdownMenuItem(
                    value: 'available for adoption',
                    child: Text('Available for Adoption')),
                DropdownMenuItem(value: 'adopted', child: Text('Adopted')),
                DropdownMenuItem(
                    value: 'needs rescue', child: Text('Needs Rescue')),
              ],
            ),
            ElevatedButton(
              onPressed: submitAnimalDetails,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
