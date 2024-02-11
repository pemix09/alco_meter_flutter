import 'package:alco_meter_flutter/app/domain/repositories/drink_repo.dart';
import 'package:alco_meter_flutter/app/data/models/drink.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class DrinkService {
  late final DrinkRepository drinkRepository;
  late final Logger logger;
  late List<Drink> drinks;

  DrinkService() {
    final services = GetIt.instance;
    drinkRepository = services.get<DrinkRepository>();
    logger = services.get<Logger>();
    drinks = <Drink>[];
  }

  Future<List<Drink>> getDrinks() async {

    if (drinks.isEmpty) {
      drinks = await drinkRepository.getDrinks();
    }

    return drinks;
  }

  Future<void> addDrink(Drink drink) async {
    logger.d('Drink: ${drink.amount} ml, ${drink.percentage}%, ${drink.id}');
    await drinkRepository.addDrink(drink);
  }

  Future<void> deleteDrink(Drink drink) async {
    await drinkRepository.deleteDrink(drink);
  }
}