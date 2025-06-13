import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Add this import
import 'dart:io';

class AddAnimalForm extends StatefulWidget {
  @override
  _AddAnimalFormState createState() => _AddAnimalFormState();
}

class _AddAnimalFormState extends State<AddAnimalForm> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  String category = 'Dog';
  String status = 'available for adoption';
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> submitAnimalDetails() async {
    final url = Uri.parse('https://minor-backend-xi.vercel.app/api/animal/add');

    var request = http.MultipartRequest('POST', url);

    // Adding fields to the request
    request.fields['category'] = category.toLowerCase();
    request.fields['description'] = descriptionController.text;
    request.fields['status'] = status;
    request.fields['location'] = locationController.text;
    request.fields['contact'] = contactController.text;
    print(request.fields);
    // Adding image file if it exists
    if (_image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _image!.path,
        contentType:
            MediaType('image', 'jpeg'), // Uses MediaType from http_parser
      ));
    }

    try {
      final response = await request.send();

      if (response.statusCode == 201 || response.statusCode == 200) {
        print("Animal added successfully");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Animal added successfully!'),
        ));
      } else {
        print("Failed to add animal. Status code: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to add animal.'),
        ));
      }
    } catch (e) {
      print("An error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred while adding the animal.'),
      ));
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
            // Dropdown for Category
            DropdownButtonFormField<String>(
              value: category,
              onChanged: (newCategory) {
                setState(() {
                  category = newCategory!;
                });
              },
              items: [
                DropdownMenuItem(value: 'Dog', child: Text('Dog')),
                DropdownMenuItem(value: 'Cat', child: Text('Cat')),
                DropdownMenuItem(value: 'Bird', child: Text('Bird')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              decoration: InputDecoration(labelText: 'Category'),
              isExpanded: true,
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

            // Dropdown for Status
            DropdownButtonFormField<String>(
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
              decoration: InputDecoration(labelText: 'Status'),
              isExpanded: true,
            ),

            // Image Upload Button
            SizedBox(height: 20),
            _image == null
                ? Text("No image selected.")
                : Image.file(_image!, height: 100, width: 100),
            ElevatedButton.icon(
              icon: Icon(Icons.add_a_photo),
              label: Text("Add Image"),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Wrap(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.photo_library),
                          title: Text('Upload from Gallery'),
                          onTap: () {
                            _pickImage(ImageSource.gallery);
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.camera_alt),
                          title: Text('Open Camera'),
                          onTap: () {
                            _pickImage(ImageSource.camera);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            SizedBox(height: 20),
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
