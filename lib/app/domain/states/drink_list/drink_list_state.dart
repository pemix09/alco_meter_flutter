import 'package:alco_meter_flutter/app/data/models/drink.dart';
import 'package:alco_meter_flutter/app/data/models/user.dart';

class DrinkListState {
  late final User? user;
  late final List<Drink> drinks;
  int get drinksCount => drinks.length;

  DrinkListState({this.user, List<Drink>? drinks}) {
    this.drinks = drinks ?? <Drink>[];
  }

  DrinkListState copyWith({List<Drink>? drinks, User? user}) {
    return DrinkListState(
      user: user ?? this.user,
      drinks: drinks ?? this.drinks,
    );
  }
}

class DrinkListInitialState extends DrinkListState {
  DrinkListInitialState()
      : super(
          drinks: <Drink>[],
        );
}

class DrinkListChangedState extends DrinkListState {
  final List<Drink> drinks;

  DrinkListChangedState({required this.drinks}) : super();
}

class DrinkListLoadedState extends DrinkListState {
  final List<Drink> drinks;

  DrinkListLoadedState({required this.drinks}) : super();
}

class DrinkListErrorState extends DrinkListState {
  final String message;

  DrinkListErrorState(this.message) : super();
}
