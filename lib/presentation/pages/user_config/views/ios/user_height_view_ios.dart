import 'package:alco_meter_flutter/presentation/components/texts/header_text.dart';
import 'package:alco_meter_flutter/presentation/components/texts/user_input_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:alco_meter_flutter/presentation/pages/user_config/user_config_page.dart';

class UserHeightViewIos extends HookWidget {
  final int valueChangeJump = 5;
  late final int numberOfDivisions;

  UserHeightViewIos({super.key}) {
    var heightRange =
        UserConfigPage.maxUserHeight - UserConfigPage.minUserHeight;
    var numberOfDivisions = heightRange / valueChangeJump;
    this.numberOfDivisions = numberOfDivisions.toInt();
  }

  @override
  Widget build(BuildContext context) {
    final useSliderValue = useState<int>(160);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.height,
          color: Colors.white,
          size: 150,
        ),
        const SizedBox(height: 5),
        const HeaderText(headerText: 'What is your height?'),
        const SizedBox(height: 15),
        UserInputText(userInputText: '${useSliderValue.value} cm'),
        const SizedBox(height: 5),
        CupertinoSlider(
          min: UserConfigPage.minUserHeight.toDouble(),
          max: UserConfigPage.maxUserHeight.toDouble(),
          value: useSliderValue.value.toDouble(),
          divisions: numberOfDivisions,
          onChanged: (newValue) => {useSliderValue.value = newValue.toInt()},
        ),
      ],
    );
  }
}
