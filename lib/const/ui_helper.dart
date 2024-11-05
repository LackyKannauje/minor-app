import 'package:flutter/material.dart';

// ignore: must_be_immutable
class boxes extends StatefulWidget {
  var txt;
  IconData iconData;
  bool obscuretext;
  var controller;
  Function? pass;

  boxes(
      {required this.txt,
      required this.iconData,
      required this.obscuretext,
      required this.controller,
      this.pass});

  @override
  State<boxes> createState() => _boxesState();
}

class _boxesState extends State<boxes> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscuretext,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () => widget.pass, icon: Icon(widget.iconData)),
        labelText: widget.txt,
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
