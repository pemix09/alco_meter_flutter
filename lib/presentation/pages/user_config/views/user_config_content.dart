import 'dart:io';
import 'package:alco_meter_flutter/app/enums/direction.dart';
import 'package:alco_meter_flutter/presentation/pages/user_config/views/android/user_height_view_android.dart';
import 'package:alco_meter_flutter/presentation/pages/user_config/views/ios/user_height_view_ios.dart';
import 'package:alco_meter_flutter/presentation/pages/user_config/views/user_config_view_template.dart';
import 'package:alco_meter_flutter/presentation/pages/user_config/views/ios/user_sex_view_ios.dart';
import 'package:alco_meter_flutter/presentation/pages/user_config/views/ios/user_weight_view_ios.dart';
import 'package:flutter/material.dart';

enum UserConfigViewType {
  heightView,
  weightView,
  sexView,
}

class UserConfigContent extends StatefulWidget {
  const UserConfigContent({super.key});
  
  @override
  State<StatefulWidget> createState() => UserConfigContentState();
}

class UserConfigContentState extends State<UserConfigContent> {
  int get maxIndex => UserConfigViewType.values.length - 1;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return IndexedStack(index: currentIndex, children: getContentViews());
  }

  List<Widget> getContentViews() {
    var views = <Widget>[];

    for (var viewType in UserConfigViewType.values) {
      views.add(UserConfigViewTemplate(
        title: viewType.toString(),
        content: getContent(viewType),
        onChangeViewClicked: (Direction dir) { 
          setState(() {
            currentIndex = getNextIndex(dir, currentIndex, maxIndex);
          });
          },
      ));
    }
    return views;
  }

  Widget getContent(UserConfigViewType viewType) {
    if (viewType == UserConfigViewType.weightView) {
      return UserWeightViewIos();
    } else if (viewType == UserConfigViewType.sexView) {
      return const UserSexViewIos();
    } else if (viewType == UserConfigViewType.heightView) {
      if (Platform.isIOS) {
        return UserHeightViewIos();
      } else {
        return const UserHeightViewAndroid();
      }
    } else {
      throw Exception('Unknown user config viewType');
    }
  }

  int getNextIndex(Direction direction, int currentIndex, int maxIndex) {
    if (direction == Direction.next) {
      if (currentIndex == maxIndex) {
        return 0;
      } else {
        return currentIndex + 1;
      }
    } else if (direction == Direction.previous) {
      if (currentIndex == 0) {
        return maxIndex;
      } else {
        return currentIndex - 1;
      }
    } else {
      throw Exception('Unknown direction in nextIndex function');
    }
  }
}
