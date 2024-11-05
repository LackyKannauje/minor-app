import 'package:flutter/material.dart';
import '../const/profile_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        title: Text('Profile'),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(isDark ? Icons.sunny : Icons.mood))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              CircleAvatar(
                backgroundImage: AssetImage("assets/profile.jpg"),
                radius: 55,
              ),
              Text(
                'RescuHub',
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
              Text("random@gmail.com"),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                    // TODO: do not hardcode colors - use theming instead!
                    foregroundColor: Colors.white, // foreground (text) color
                    backgroundColor: Color.fromRGBO(255, 103, 103, 1),
                    fixedSize: Size(170, 40)),
              ),
              SizedBox(
                height: 50,
              ),
              ProfileText(
                leadingIcon: Icons.home,
                trailingIcon: Icons.arrow_forward,
                title: "Home",
              ),
              ProfileText(
                leadingIcon: Icons.settings,
                trailingIcon: Icons.arrow_forward,
                title: "Setting",
              ),
              ProfileText(
                leadingIcon: Icons.error,
                trailingIcon: Icons.arrow_forward,
                title: "About",
              ),
              ProfileText(
                leadingIcon: Icons.lock,
                trailingIcon: Icons.arrow_forward,
                title: "Privacy Policy",
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromRGBO(255, 103, 103, 1)),
                label: Text('Log Out'),
                icon: Icon(Icons.logout),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
