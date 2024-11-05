import 'package:flutter/material.dart';

class MissingReport extends StatelessWidget {
  const MissingReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "Name of Pet",
            ),
          )
        ],
      ),
    );
  }
}
