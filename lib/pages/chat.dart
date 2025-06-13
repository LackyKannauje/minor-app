import 'package:flutter/material.dart';
import 'package:animal_rescue_application/const/const.dart';
import 'package:animal_rescue_application/pages/message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

List list = [
  'K',
  'L',
  'M',
  'N',
];

List name = [
  'Naruto Uzumaki',
  'Obito Uchiha',
  'Kakashi Hatake',
  'Zoro Roronoa',
];

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: primaryColor,
              foregroundColor: thirdColor,
              child: Text(name[index].toString().substring(0, 1)),
            ),
            title: Text(
              name[index],
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text('My pet is lost help me to find it.'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Message()));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        foregroundColor: thirdColor,
        child: Icon(Icons.call),
      ),
    );
  }
}
