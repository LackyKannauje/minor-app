import 'package:flutter/material.dart';

class ProfileText extends StatelessWidget {
  const ProfileText({
    required this.leadingIcon,
    required this.trailingIcon,
    required this.title,
  });

  final IconData leadingIcon;
  final IconData trailingIcon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 20, right: 10),
      child: ListTile(
        onLongPress: () => {},
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color.fromRGBO(255, 103, 103, 1)),
          child: Icon(
            leadingIcon as IconData?,
            color: Colors.white,
          ),
        ),
        title: Text(title),
        trailing: Icon(trailingIcon as IconData),
      ),
    );
  }
}
