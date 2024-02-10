import 'package:alco_meter_flutter/data/models/drink.dart';

class DrinkService {
  //for caching
  late final List<Drink> drinks;

  DrinkService() {
    drinks = <Drink>[];
  }

  Future<List<Drink>> getDrinks() async {
    return drinks;
  }

  void addDrink(Drink drink) {
    drinks.add(drink);
  }

  void deleteDrink(Drink drink) {
    drinks.remove(drink);
  }

  void addPhotoToDrink(Drink drink, String photoPath) {
    drink.photoPath = photoPath;
  }
}