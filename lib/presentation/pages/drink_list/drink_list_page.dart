import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class DrinkListPage extends StatelessWidget {
  static const String routeName = 'drinkList';

  const DrinkListPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: Text('drink list works'),
      );
    } else {
      return Scaffold(
        body: Text('drink list works'),
      );
    }
  }
}