import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  var message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ContactName'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 600, left: 25, right: 25),
        child: TextField(
          decoration: InputDecoration(
              fillColor: Colors.grey.shade200,
              suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.send)),
              labelText: "Type a message",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(100))),
        ),
      ),
    );
  }
}
