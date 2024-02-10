import 'package:alco_meter_flutter/data/enums/sex.dart';
import 'package:alco_meter_flutter/data/models/drink.dart';
import 'package:alco_meter_flutter/data/models/user_config.dart';

class AlcoholCalculator {

  double calculateAlcoholLevel(List<Drink> drinks, UserSetup userSetup) {
    drinks.sort((a, b) => a.timeAdded.compareTo(b.timeAdded));
    double promiles = 0;

    for (int i = 0; i < drinks.length; i++) {
      var drink = drinks[i];
      var nextDrink = i + 1 < drinks.length ? drinks[i + 1] : null;

      if (nextDrink != null) {
        promiles += getAlcoholPromilesLeftOfDrink(drink, nextDrink.timeAdded, userSetup);
      } else {
        promiles += getAlcoholPromilesLeftOfDrink(drink, DateTime.now(), userSetup);
      }
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

  double getAlcoholPromilesLeftOfDrink(Drink drink, DateTime stoppedDigestion, UserSetup user) {
    var timeDigesting = stoppedDigestion.difference(drink.timeAdded);
    var amountOfAlkohol = drink.amount * drink.percentage / 100;
  
    var promilesLeft = getPromiles(amountOfAlkohol, user) - getDisgestedPromiles(timeDigesting);

    if (promilesLeft < 0) {
      return 0;
    } else {
      return promilesLeft;
    }
  }

  double getDisgestedPromiles(Duration digestionDuration) {
    var hours = digestionDuration.inHours * 60;
    var minutes = digestionDuration.inMinutes;
    var totalTime = hours + minutes;

    return totalTime * 0.15 / 60;
  }

  double getPromiles(double alcoholAmount, UserSetup user) {
    var sexFactor = user.sex == Sex.male ? 0.7 : 0.6;

    return alcoholAmount / (sexFactor * user.weight);
  }
}
