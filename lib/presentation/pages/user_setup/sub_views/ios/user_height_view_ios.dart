import 'package:alco_meter_flutter/app/states/user_setup/user_setup_bloc.dart';
import 'package:alco_meter_flutter/app/states/user_setup/user_setup_event.dart';
import 'package:alco_meter_flutter/presentation/components/texts/header_text.dart';
import 'package:alco_meter_flutter/presentation/components/texts/user_input_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';import 'package:get_it/get_it.dart';

var services = GetIt.instance;

class UserHeightViewIos extends HookWidget {
  static const maxUserHeight = 300;
  static const minUserHeight = 120;
  static const valueChangeJump = 5;
  late final int numberOfDivisions;
  late final UserSetupBloc bloc;

  UserHeightViewIos({super.key}) {
    var heightRange = maxUserHeight - minUserHeight;
    var numberOfDivisions = heightRange / valueChangeJump;
    this.numberOfDivisions = numberOfDivisions.toInt();
    bloc = services.get<UserSetupBloc>();
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
        const HeaderText('What is your height?'),
        const SizedBox(height: 15),
        UserInputText(userInputText: '${useSliderValue.value} cm'),
        const SizedBox(height: 5),
        CupertinoSlider(
          min: minUserHeight.toDouble(),
          max: maxUserHeight.toDouble(),
          value: useSliderValue.value.toDouble(),
          divisions: numberOfDivisions,
          onChangeEnd: (value) {
            bloc.add(HeightEnteredEvent(userHeight: value));
          },
          onChanged: (newValue) => {useSliderValue.value = newValue.toInt()},
        ),
      ],
    );
  }
}
