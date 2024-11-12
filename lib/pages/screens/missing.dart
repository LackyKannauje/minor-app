import 'dart:io';
import 'package:flutter/material.dart';
import 'package:minor_app/const/const.dart';
import 'package:http/http.dart' as http;

class AnimalRescueForm extends StatefulWidget {
  final File? image;

  AnimalRescueForm({this.image});

  @override
  _AnimalRescueFormState createState() => _AnimalRescueFormState();
}

class _AnimalRescueFormState extends State<AnimalRescueForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _petController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String pet = _petController.text;
      String description = _descriptionController.text;
      String location = _locationController.text;

      var uri = Uri.parse('https://Change-The-API-of-Your-Backend/api/missing');
      var request = http.MultipartRequest('POST', uri)
        ..fields['pet'] = pet
        ..fields['description'] = description
        ..fields['location'] = location;

      if (widget.image != null) {
        // Attach the image as multipart form data
        var imageFile = await http.MultipartFile.fromPath(
          'image', // Field name in the backend
          widget.image!.path,
        );
        request.files.add(imageFile);
      }

      try {
        // Send the request
        var response = await request.send();

        if (response.statusCode == 200) {
          // Successfully submitted
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Animal Issue Submitted Successfully!')),
          );
          // Optionally, navigate to another page
        } else {
          // Handle failure
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to submit the issue. Please try again.')),
          );
        }
      } catch (e) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
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
              TextFormField(
                controller: _petController,
                decoration: InputDecoration(
                  labelText: "Enter a Pet or Name",
                  prefixIcon: Icon(Icons.pets),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  return value!.isEmpty ? "Please Enter Name or Pet" : null;
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
                      //backend --> code waiting
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
