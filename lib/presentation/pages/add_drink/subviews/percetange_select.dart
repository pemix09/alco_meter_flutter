import 'package:alco_meter_flutter/app/states/add_drink/add_drink_bloc.dart';
import 'package:alco_meter_flutter/app/states/add_drink/add_drink_event.dart';
import 'package:alco_meter_flutter/presentation/components/texts/user_input_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

class PercentageSelect extends HookWidget {
  static const double maxPercentage = 100;
  static const double minPercentage = 0;
  static const int numberOfDivisions = 50;
  late final AddDrinkBloc bloc;

  PercentageSelect({super.key}) {
    final services = GetIt.instance;
    bloc = services.get<AddDrinkBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final usePercentage = useState<double>(bloc.state.percentage);

    return Column(
      children: [
        UserInputText(
          userInputText: 'percentage: ${usePercentage.value.toInt()} %',
          color: Colors.black,
        ),
        const SizedBox(height: 5),
        CupertinoSlider(
          min: minPercentage,
          max: maxPercentage,
          value: usePercentage.value.toDouble(),
          divisions: numberOfDivisions,
          onChangeEnd: (percentage) {
            bloc.add(DrinkPercentageChangedEvent(percentage));
          },
          onChanged: (percentage) {
            usePercentage.value = percentage;
          },
        ),
      ],
    );
  }
}
