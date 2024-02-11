import 'package:alco_meter_flutter/app/data/models/drink.dart';
import 'package:alco_meter_flutter/app/data/models/user.dart';

abstract class DrinkListEvent {
}

class RefreshDrinksListEvent extends DrinkListEvent {
  final User? user;

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