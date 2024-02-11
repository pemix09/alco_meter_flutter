import 'package:alco_meter_flutter/app/domain/states/user_setup/user_setup_bloc.dart';
import 'package:alco_meter_flutter/app/domain/states/user_setup/user_setup_event.dart';
import 'package:alco_meter_flutter/app/presentation/components/texts/header_text.dart';
import 'package:alco_meter_flutter/app/presentation/components/texts/user_input_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

var services = GetIt.instance;

class UserWeightViewIos extends HookWidget {
  static const int minWeight = 20;
  static const int maxWeight = 300;
  static const routeName = 'weight';
  final int valueChangeJump = 5;
  late final int numberOfDivisions;
  late final UserSetupBloc bloc;

  UserWeightViewIos({super.key}) {
    var weightRange = maxWeight - minWeight;
    var numberOfDivisions = weightRange / valueChangeJump;
    this.numberOfDivisions = numberOfDivisions.toInt();
    bloc = services<UserSetupBloc>();
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
        const HeaderText('What is your weight?'),
        const SizedBox(height: 15),
        UserInputText(userInputText: '${useSliderValue.value} kg'),
        const SizedBox(height: 5),
        CupertinoSlider(
          min: minWeight.toDouble(),
          max: maxWeight.toDouble(),
          value: useSliderValue.value.toDouble(),
          divisions: numberOfDivisions,
          onChangeEnd: (value) {
            bloc.add(WeightEnteredEvent(userWeight: value));
          },
          onChanged: (newValue) {
            useSliderValue.value = newValue.toInt();
            },
        ),
      ],
    );
  }
}