import 'package:alco_meter_flutter/app/services/alco_calc.dart';
import 'package:alco_meter_flutter/app/states/drink_list/drink_list_bloc.dart';
import 'package:alco_meter_flutter/app/states/user_setup/user_setup_bloc.dart';
import 'package:alco_meter_flutter/data/models/user_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:styled_widget/styled_widget.dart';

class DrinkListSummary extends HookWidget {
  late final DrinkListBloc bloc;
  late final AlcoholCalculator alcoholCalculator;
  late final Logger logger;

  DrinkListSummary({super.key}) {
    final services = GetIt.instance;
    bloc = services.get<DrinkListBloc>();
    alcoholCalculator = services.get<AlcoholCalculator>();
  }

  @override
  Widget build(BuildContext context) {
    var promiles = alcoholCalculator.calculateAlcoholLevel(
        bloc.state.drinks, bloc.state.user);
    var timeToSober =
        alcoholCalculator.calculateTimeToSober(promiles, bloc.state.user);
    var dateSober = getSoberWhen(timeToSober);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildPromilesDisplay(),
        if (promiles != 0)
          Text(
            'Sober on: $dateSober',
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
      ],
    ).center().backgroundColor(Colors.deepPurple);
  }

  Widget buildPromilesDisplay() {
    return StreamBuilder(
      stream: bloc.promilesStream,
      builder: (ctx, snapshot) => Text(
        'Alcohol level: ${snapshot.data?.toStringAsPrecision(2)}‰',
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  String getSoberWhen(Duration timeToSober) {
    var dateSober = DateTime.now().add(timeToSober);

    if (dateSober.minute < 10) {
      return '${dateSober.hour}:0${dateSober.minute}';
    } else {
      return '${dateSober.hour}:${dateSober.minute}';
    }
  }
}
