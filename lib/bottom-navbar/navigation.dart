import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:minor_app/pages/chat.dart';
import 'package:minor_app/const/const.dart';
import 'package:minor_app/pages/emergency_call_page.dart';
import 'package:minor_app/pages/home.dart';
import 'package:minor_app/pages/profile.dart';
import 'package:minor_app/pages/animal_card.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final token;
  const MyBottomNavigationBar({@required this.token, super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  var _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      HomePage(token: widget.token),
      EmergencyCallPage(),
      AnimalListPage(),
      ChatPage(),
      ProfilePage()
    ];
    return Scaffold(
      body: list[_selectedIndex],
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        iconSize: 25,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          _flashyItems("Home", Icons.home),
          _flashyItems("Rescue", Icons.call),
          _flashyItems("Adopt", Icons.pets),
          _flashyItems("Chat", Icons.chat),
          _flashyItems("Profile", Icons.person),
        ],
      ),
    );
  }

  FlashyTabBarItem _flashyItems(String title, IconData icon) {
    return FlashyTabBarItem(
      icon: Icon(
        icon,
      ),
      title: Text(
        title,
      ),
      activeColor: primaryColor,
      inactiveColor: navbarColor,
    );
  }
}
