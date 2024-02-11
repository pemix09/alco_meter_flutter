import 'package:alco_meter_flutter/app/data/models/drink.dart';
import 'package:hive/hive.dart';

class DrinkRepository {
  static const drinksBoxName = 'drinksBox';
  final drinks = <Drink>[];

  Future<void> addDrink(Drink drink) async {
    drinks.add(drink);
    var drinksBox = await Hive.openBox<Drink>(drinksBoxName);
    await drinksBox.put(drink.id.toString(), drink);
  }

  Future<List<Drink>> getDrinks() async {
    if (drinks.isNotEmpty) return drinks;
    
    var drinksBox = await Hive.openBox<Drink>(drinksBoxName);
    return drinksBox.values.toList();
  }

  Future<void> deleteDrink(Drink drink) async {
    var drinksBox = await Hive.openBox<Drink>(drinksBoxName);
    await drinksBox.delete(drink.id);
  }
}