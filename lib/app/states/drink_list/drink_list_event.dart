import 'package:alco_meter_flutter/data/models/drink.dart';
import 'package:alco_meter_flutter/data/models/user_config.dart';

abstract class DrinkListEvent {
}

class RefreshDrinksListEvent extends DrinkListEvent {
  final UserSetup? user;

  RefreshDrinksListEvent({this.user});
}

class DeleteDrinkEvent extends DrinkListEvent {
  final Drink drink;

  DeleteDrinkEvent({required this.drink});
}

class MakePhotoEvent extends DrinkListEvent {
  final Drink drink;

  MakePhotoEvent({required this.drink});
}