import 'dart:io';
import 'package:animal_rescue_application/admin/pages/adoption/adoptionForm.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPageAdmin extends StatefulWidget {
  @override
  _CameraPageAdminState createState() => _CameraPageAdminState();
}

class _CameraPageAdminState extends State<CameraPageAdmin> {
  final ImagePicker _picker = ImagePicker();

  Future<void> captureImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AnimalAdoptionAdminForm(image: File(pickedFile.path)),
          ),
        );
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture or Select Image'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => captureImage(ImageSource.camera),
              icon: const Icon(Icons.camera),
              label: const Text('Capture from Camera'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => captureImage(ImageSource.gallery),
              icon: const Icon(Icons.photo_library),
              label: const Text('Select from Gallery'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
