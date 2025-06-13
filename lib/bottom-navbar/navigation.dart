import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:animal_rescue_application/admin/pages/adoption/adoptionPage.dart';
import 'package:animal_rescue_application/admin/pages/dashboard_page.dart';
import 'package:animal_rescue_application/admin/pages/rescue/rescuePage.dart';
import 'package:animal_rescue_application/chatbot/how_to_use.dart';
import 'package:animal_rescue_application/pages/chat.dart';
import 'package:animal_rescue_application/const/const.dart';
import 'package:animal_rescue_application/pages/emergency_call_page.dart';
import 'package:animal_rescue_application/pages/home.dart';
import 'package:animal_rescue_application/pages/profile.dart';
import 'package:animal_rescue_application/pages/animal_card.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final String? role;
  const MyBottomNavigationBar({required this.role, super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> userList = [
      HomePage(),
      EmergencyCallPage(),
      AnimalListPage(),
      ChatPage(),
      ProfilePage()
    ];
    List<Widget> adminList = [
      DashboardPage(),
      AdoptionPage(),
      MainPage(),
    ];
    return Scaffold(
      body: widget.role == 'ADMIN'
          ? adminList[_selectedIndex]
          : userList[_selectedIndex],
      floatingActionButton: widget.role != 'ADMIN'
          ? FloatingActionButton(
              backgroundColor: primaryColor,
              child: Icon(Icons.support_agent_sharp,
                  color: Colors.white, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HowToUseChatbotPage(),
                  ),
                );
              },
            )
          : null,
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        iconSize: 25,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: widget.role == 'ADMIN'
            ? [
                _flashyItems("Home", Icons.bar_chart),
                _flashyItems("Adoption", Icons.pets),
                _flashyItems("Rescue", Icons.emoji_nature),
              ]
            : [
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
