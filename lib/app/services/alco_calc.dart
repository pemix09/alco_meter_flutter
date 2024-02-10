import 'package:alco_meter_flutter/data/enums/sex.dart';
import 'package:alco_meter_flutter/data/models/drink.dart';
import 'package:alco_meter_flutter/data/models/user_config.dart';

class AlcoholCalculator {
  double calculateAlcoholLevel(List<Drink> drinks, UserSetup userSetup) {
    double promiles = 0;

    for (var drink in drinks) {
      var alcoholAmount = getAlcoholAmountOfDrink(drink);
      promiles += getPromiles(alcoholAmount, userSetup);
    }

    return promiles;
  }

  Duration calculateTimeToSober(double promiles, UserSetup user) {
    var hoursToSober = promiles / 0.15;
    var hoursInt = hoursToSober.toInt();
    var minutes = (hoursToSober - hoursInt) * 60;

    return Duration(
      hours: hoursInt,
      minutes: minutes.toInt(),
    );
  }

  double getAlcoholAmountOfDrink(Drink drink) {
    return drink.amount * drink.percentage / 100;
  }

  double getPromiles(double alcoholAmount, UserSetup user) {
    var sexFactor = user.sex == Sex.male ? 0.7 : 0.6;

    return alcoholAmount / (sexFactor * user.weight);
  }
}
