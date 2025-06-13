import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:animal_rescue_application/const/globles.dart';

class AnimalDetailPage extends StatefulWidget {
  final Map<String, dynamic> animal;

  AnimalDetailPage({required this.animal});

  @override
  State<AnimalDetailPage> createState() => _AnimalDetailPageState();
}

class _AnimalDetailPageState extends State<AnimalDetailPage> {
  Future<void> _makeCall(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  Future<void> changeStatus(String newStatus) async {
    final String animalId = widget.animal['_id'];
    final String apiUrl =
        'https://minor-backend-xi.vercel.app/api/animal/status/$animalId';
    print('$animalId $globalToken $newStatus');
    try {
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': globalToken!, // Add your auth token here
        },
        body: jsonEncode({'status': newStatus}),
      );

      print(response.body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Success: ${responseData['message']}');
        // Optionally, you can update the UI to reflect the new status
      } else {
        final responseData = jsonDecode(response.body);
        print('Error: ${responseData['message']}');
        // Handle the error accordingly
      }
    } catch (error) {
      print('Network error: $error');
      // Handle network error accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 103, 103, 1),
        elevation: 0,
        title: Text(
          'Animal Detail',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                    color: Colors.black, blurRadius: 2, offset: Offset(2, 2)),
              ]),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image Section
              _buildHeroImage(),
              SizedBox(height: 20),

              // Category and Status
              _buildCategoryAndStatus(),
              SizedBox(height: 20),

              // Description Section
              _buildSectionTitle('Description'),
              _buildShadowCard(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.animal['description'] ?? 'No description available.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Location Section
              _buildSectionTitle('Location'),
              _buildShadowCard(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.animal['location'] ?? 'No location available.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Contact Information Section
              _buildSectionTitle('Contact'),
              _buildShadowCard(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () => _makeCall(widget.animal['contact']),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.animal['contact'] ??
                              'No contact information available.',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(Icons.call),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Action Button
              Center(
                child: widget.animal['caseType'] != 'rescue'
                    ? _buildActionButton()
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hero Image with a stylish overlay
  Widget _buildHeroImage() {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: widget.animal['image'] != null
              ? Image.network(
                  widget.animal['image'],
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Container(
                  height: 300,
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(
                      Icons.pets,
                      size: 120,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Text(
            widget.animal['caseType'] ?? 'Unknown',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    color: Colors.black26, blurRadius: 3, offset: Offset(2, 2)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Category and Status Row
  Widget _buildCategoryAndStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCategory(),
        _buildStatusText(),
      ],
    );
  }

  // Category with Icon and Shadow
  Widget _buildCategory() {
    return Row(
      children: [
        Icon(Icons.pets, color: Color.fromRGBO(255, 103, 103, 1), size: 28),
        SizedBox(width: 8),
        Text(
          widget.animal['category'] ?? 'Unknown',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                  color: Colors.black26, blurRadius: 3, offset: Offset(1, 1)),
            ],
          ),
        ),
      ],
    );
  }

  // Status Text with Dynamic Color and Shadow
  Widget _buildStatusText() {
    return Text(
      'Status: ${widget.animal['status']}',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: _getStatusColor(widget.animal['status']),
        shadows: [
          Shadow(color: Colors.black26, blurRadius: 3, offset: Offset(1, 1)),
        ],
      ),
    );
  }

  // Section Title with styling
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
          shadows: [
            Shadow(color: Colors.black26, blurRadius: 3, offset: Offset(1, 1)),
          ],
        ),
      ),
    );
  }

  // Shadow Card for Content
  Widget _buildShadowCard({required Widget child}) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  // Action Button with gradient and rounded corners
  Widget _buildActionButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(255, 103, 103, 1),
            Color.fromRGBO(255, 152, 152, 1)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: () async {
          final status =
              widget.animal['caseType'] == 'missing' ? 'found' : 'adopted';
          await changeStatus(status);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: Text(
          widget.animal['status'].toString() == 'pending'
              ? 'Take Action'
              : 'Completed',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Status color logic
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
