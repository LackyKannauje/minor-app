import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class EmergencyCallPage extends StatelessWidget {
  final String contactNumber1 =
      '1234567890'; // Replace with actual emergency number
  final String contactNumber2 =
      '0987654321'; // Replace with actual emergency number

  Future<void> _makeCall(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contacts'),
        backgroundColor: Color(0xFFee6b6e),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildEmergencyContactItem(
              contactName: 'Rescue Team 1',
              number: contactNumber1,
            ),
            SizedBox(height: 20),
            _buildEmergencyContactItem(
              contactName: 'Rescue Team 2',
              number: contactNumber2,
            ),
          ],
        ),
      ),
    );
  }

  // Emergency contact item styled with avatar and call icon
  Widget _buildEmergencyContactItem({
    required String contactName,
    required String number,
  }) {
    return InkWell(
      onTap: () => _makeCall(number),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(10),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.2),
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //     offset: Offset(0, 2),
          //   ),
          // ],
        ),
        child: Row(
          children: [
            // Default Avatar
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: Icon(Icons.person, color: Colors.grey.shade600),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                contactName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            // Call Icon
            IconButton(
              icon: Icon(Icons.call, color: Color(0xFFee6b6e)),
              onPressed: () => _makeCall(number),
            ),
          ],
        ),
      ),
    );
  }
}
