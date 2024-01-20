import 'package:alco_meter_flutter/presentation/pages/user_config/views/user_config_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:io' show Platform;

class UserConfigPage extends HookWidget {
  static const String routeName = 'userConfig';
  static const int minUserHeight = 120;
  static const int maxUserHeight = 300;
  static const int minWeight = 20;
  static const int maxWeight = 300;

  UserConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    var userConfigContent = const UserConfigContent();
    var backgroundColor = Colors.deepPurple;

    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        backgroundColor: backgroundColor,
        child: userConfigContent,
      );
    } else {
      return Scaffold(
        body: userConfigContent,
        backgroundColor: backgroundColor,
      );
    }
  }
}
