import 'package:alco_meter_flutter/app/domain/states/add_drink/add_drink_bloc.dart';
import 'package:alco_meter_flutter/app/domain/states/add_drink/add_drink_event.dart';
import 'package:alco_meter_flutter/app/data/enums/drink_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

class DrinkSelect extends HookWidget {
  late final AddDrinkBloc bloc;

  DrinkSelect({super.key}) {
    final services = GetIt.instance;
    bloc = services.get<AddDrinkBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final useSelectedDrink = useState<DrinkType?>(bloc.state.drinkType);

    return Column(
      children: [
        CupertinoSegmentedControl<DrinkType>(
          groupValue: useSelectedDrink.value,
          onValueChanged: (selectedDrink) {
            useSelectedDrink.value = selectedDrink;
            bloc.add(DrinkTypeChangedEvent(selectedDrink));
          },
          children: const <DrinkType, Widget>{
            DrinkType.beer: Icon(
              Icons.border_vertical,
              size: 100,
              color: Colors.black,
            ),
            DrinkType.wine: Icon(
              Icons.wine_bar,
              size: 100,
              color: Colors.black,
            ),
            DrinkType.vodka: Icon(
              Icons.local_bar,
              size: 100,
              color: Colors.black,
            ),
          },
        ),
        if (useSelectedDrink.value != null)
          Text(
            'selected drink: ${useSelectedDrink.value!.name}',
            style: const TextStyle(
              color: Colors.black,
              decoration: TextDecoration.none,
              fontStyle: FontStyle.italic,
              fontSize: 25,),
          )
      ],
    );
  }
}
