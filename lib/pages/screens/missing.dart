import 'dart:io';
import 'package:flutter/material.dart';
import 'package:minor_app/const/config.dart';
import 'package:minor_app/const/const.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
// import 'package:mime/mime.dart';

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
  final TextEditingController _contactController = TextEditingController();

  Future<void> submitAnimalDetails() async {
    final url = Uri.parse('$apiBaseUrl/api/animal/add');

    var request = http.MultipartRequest('POST', url);

    request.fields['category'] = _petController.text;
    request.fields['description'] = _descriptionController.text;
    request.fields['status'] = 'missing';
    request.fields['location'] = _locationController.text;
    request.fields['contact'] = _contactController.text;

    // print(request.fields);
    if (widget.image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        widget.image!.path,
        contentType: MediaType('image', 'jpeg'),
      ));
    }
    print(request.fields);

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print(responseBody);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print("Animal added successfully");
        // ignore: use_build_context_synchronously
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Rescue Req added successfully!'),
          ));
        }
      } else {
        print("Failed to add animal. Status code: ${response.statusCode}");
        // ignore: use_build_context_synchronously
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to add Request.'),
          ));
        }
      }
    } catch (e) {
      print("An error occurred: $e");

      // ignore: use_build_context_synchronously
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occurred while adding the req.'),
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
