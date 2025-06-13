import 'dart:io';
import 'package:animal_rescue_application/const/const.dart';
import 'package:animal_rescue_application/const/globles.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
// import 'package:mime/mime.dart';

class AnimalAdoptionAdminForm extends StatefulWidget {
  final File? image;

  AnimalAdoptionAdminForm({this.image});

  @override
  _AnimalAdoptionAdminFormState createState() =>
      _AnimalAdoptionAdminFormState();
}

class _AnimalAdoptionAdminFormState extends State<AnimalAdoptionAdminForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _petController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  Future<void> submitAnimalDetails() async {
    final url = Uri.parse('https://minor-backend-xi.vercel.app/api/animal/add');

    var request = http.MultipartRequest('POST', url);

    request.fields['category'] = _petController.text.toLowerCase();
    request.fields['caseType'] = 'adoption';
    request.fields['description'] = _descriptionController.text;
    request.fields['location'] = _locationController.text;
    request.fields['contact'] = _contactController.text;
    if (globalToken != null) {
      request.headers.addAll({'x-auth-token': globalToken!});
    }
    if (widget.image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        widget.image!.path,
        contentType: MediaType('image', 'jpeg'),
      ));
    }

    try {
      final response = await request.send();

      if (response.statusCode == 201 || response.statusCode == 200) {
        print("Animal added successfully");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Rescue Request added successfully!'),
          ));
        }
      } else {
        print("Failed to add animal. Status code: ${response.statusCode}");
        print(response);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to add Request.'),
          ));
        }
      }
    } catch (e) {
      print("An error occurred: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occurred while adding the request.'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report Animal Issue"),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // pet Field
              Text(
                "Pet (e.g. dog, cat...)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _petController.text.isEmpty
                    ? null
                    : _petController.text, // Initial value
                decoration: InputDecoration(
                  labelText: "Select Pet Type",
                  prefixIcon: Icon(Icons.pets),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: ["Dog", "Cat", "Bird", "Rabbit", "Other"]
                    .map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _petController.text = value ?? ""; // Update the controller
                  });
                },
                validator: (value) {
                  return value == null || value.isEmpty
                      ? "Please select a pet type"
                      : null;
                },
              ),

              SizedBox(height: 20),
              Text(
                "Mobile Number",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _contactController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Enter your Mobile No.",
                  prefixIcon: Icon(Icons.phone),
                  filled: true,
                  hintText: "e.g. 785612xxxx (don't write +91)",
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  return value!.isEmpty || value.length != 10
                      ? "Please Enter valid Mobile Number"
                      : null;
                },
              ),
              SizedBox(height: 20),

              // Description Field
              Text(
                "Description",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "Describe the issue or Problem",
                  prefixIcon: Icon(Icons.description),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 3,
                validator: (value) {
                  return value!.isEmpty ? "Please enter a description" : null;
                },
              ),
              SizedBox(height: 20),

              // Location Field
              Text(
                "Location",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: "Enter the location",
                  prefixIcon: Icon(Icons.location_on),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  return value!.isEmpty ? "Please enter the location" : null;
                },
              ),
              SizedBox(height: 20),

              // Image Preview
              widget.image == null
                  ? Center(
                      child: Text(
                        "No image captured.",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    )
                  : Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          widget.image!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              SizedBox(height: 30),

              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      submitAnimalDetails();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.send),
                  label: Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
