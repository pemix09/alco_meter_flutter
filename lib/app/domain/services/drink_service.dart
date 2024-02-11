import 'package:alco_meter_flutter/app/domain/repositories/drink_repo.dart';
import 'package:alco_meter_flutter/app/data/models/drink.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class DrinkService {
  late final DrinkRepository drinkRepository;
  late final Logger logger;

  DrinkService() {
    final services = GetIt.instance;
    drinkRepository = services.get<DrinkRepository>();
    logger = services.get<Logger>();
  }

  Future<List<Drink>> getDrinks() async {
    return await drinkRepository.getDrinks();
  }

  Future<void> addDrink(Drink drink) async {
    logger.d('Drink: ${drink.amount} ml, ${drink.percentage}%, ${drink.id}');
    await drinkRepository.addDrink(drink);
  }

  Future<void> deleteDrink(Drink drink) async {
    await drinkRepository.deleteDrink(drink);
  }
}