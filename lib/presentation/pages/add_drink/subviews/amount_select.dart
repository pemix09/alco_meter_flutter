import 'package:alco_meter_flutter/app/states/add_drink/add_drink_bloc.dart';
import 'package:alco_meter_flutter/app/states/add_drink/add_drink_event.dart';
import 'package:alco_meter_flutter/presentation/components/texts/user_input_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

class AmountSelect extends HookWidget {
  static const double maxAmount = 500;
  static const double minAmount = 10;
  static const int numberOfDivisions = 50;
  late final AddDrinkBloc bloc;

  AmountSelect({super.key}) {
    final services = GetIt.instance;
    bloc = services.get<AddDrinkBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final useAmount = useState<double>(bloc.state.volume);

    return Column(
      children: [
        UserInputText(
          userInputText: 'amount: ${useAmount.value} ml',
          color: Colors.black,
        ),
        const SizedBox(height: 5),
        CupertinoSlider(
          min: minAmount,
          max: maxAmount,
          value: useAmount.value,
          divisions: numberOfDivisions,
          onChangeEnd: (volume) {
            bloc.add(DrinkVolumeChangedEvent(volume));
          },
          onChanged: (volume) {
            useAmount.value = volume;
          },
        ),
      ],
    );
  }
}