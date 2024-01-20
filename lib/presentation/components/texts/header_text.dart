import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String headerText;

  const HeaderText({super.key, required this.headerText});

  @override
  Widget build(BuildContext context) {
    return Text(
      headerText,
      style: const TextStyle(
        color: Colors.white,
        decoration: TextDecoration.none,
        fontSize: 30,
      ),
    );
  }
}
