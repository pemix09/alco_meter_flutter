import 'package:flutter/material.dart';

class UserInputText extends StatelessWidget {
  final String userInputText;

  const UserInputText({super.key, required this.userInputText});

  @override
  Widget build(BuildContext context) {
    return Text(
      userInputText,
      style: const TextStyle(
        color: Colors.white,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.italic,
        fontSize: 25,
      ),
    );
  }
}