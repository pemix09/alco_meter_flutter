import 'package:alco_meter_flutter/app/data/enums/sex.dart';
import 'package:alco_meter_flutter/app/data/models/drink.dart';
import 'package:alco_meter_flutter/app/data/models/user.dart';

class AlcoholCalculator {

  double calculateAlcoholLevel(List<Drink>? drinks, User? userSetup) {

    if (drinks == null || userSetup == null || drinks.isEmpty) {
      return 0;
    }

    drinks.sort((a, b) => a.timeAdded.compareTo(b.timeAdded));
    double promiles = 0;

    for (int i = 0; i < drinks.length; i++) {
      if (i + 1 < drinks.length) {
        promiles += getAlcoholPromilesLeftOfDrink(drinks[i], drinks[i + 1].timeAdded, userSetup);
      } else {
        promiles += getAlcoholPromilesLeftOfDrink(drinks[i], DateTime.now(), userSetup);
      }
    }

    return promiles;
  }

  Duration calculateTimeToSober(double promiles, User? user) {

    if (user == null || promiles <= 0) {
      return const Duration();
    }

    var hoursToSober = promiles / 0.15;
    var hoursInt = hoursToSober.toInt();
    var minutes = (hoursToSober - hoursInt) * 60;

    return Duration(
      hours: hoursInt,
      minutes: minutes.toInt(),
    );
  }

  double getAlcoholPromilesLeftOfDrink(Drink drink, DateTime stoppedDigestion, User user) {
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

  double getPromiles(double alcoholAmount, User user) {
    var sexFactor = user.sex == Sex.male ? 0.7 : 0.6;

    return alcoholAmount / (sexFactor * user.weight);
  }
}
