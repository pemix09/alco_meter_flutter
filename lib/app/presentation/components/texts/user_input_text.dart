import 'package:flutter/material.dart';

class UserInputText extends StatelessWidget {
  final String userInputText;
  final Color? color;

  const UserInputText({
    super.key,
    required this.userInputText,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      userInputText,
      style: TextStyle(
        color: color ?? Colors.white,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.italic,
        fontSize: 25,
      ),
    );
  }
}
