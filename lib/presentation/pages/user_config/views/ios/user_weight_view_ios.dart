import 'package:alco_meter_flutter/presentation/components/texts/header_text.dart';
import 'package:alco_meter_flutter/presentation/components/texts/user_input_text.dart';
import 'package:alco_meter_flutter/presentation/pages/user_config/user_config_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UserWeightViewIos extends HookWidget {
  final int valueChangeJump = 5;
  late final int numberOfDivisions;

  UserWeightViewIos({super.key}) {
    var weightRange =
        UserConfigPage.maxWeight - UserConfigPage.minWeight;
    var numberOfDivisions = weightRange / valueChangeJump;
    this.numberOfDivisions = numberOfDivisions.toInt();
  } 

  @override
  Widget build(BuildContext context) {
    final useSliderValue = useState<int>(160);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.width_full_outlined,
          color: Colors.white,
          size: 150,
        ),
        const SizedBox(height: 5),
        const HeaderText(headerText: 'What is your weight?'),
        const SizedBox(height: 15),
        UserInputText(userInputText: '${useSliderValue.value} kg'),
        const SizedBox(height: 5),
        CupertinoSlider(
          min: UserConfigPage.minWeight.toDouble(),
          max: UserConfigPage.maxWeight.toDouble(),
          value: useSliderValue.value.toDouble(),
          divisions: numberOfDivisions,
          onChanged: (newValue) => {useSliderValue.value = newValue.toInt()},
        ),
      ],
    );
  }
}