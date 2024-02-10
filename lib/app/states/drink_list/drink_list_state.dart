import 'package:alco_meter_flutter/data/models/drink.dart';
import 'package:alco_meter_flutter/data/models/user_config.dart';
import 'package:flutter/widgets.dart';

class DrinkListState {
  late final UserSetup user;
  late final List<Drink> drinks;
  int get drinksCount => drinks.length;

  DrinkListState({UserSetup? user, List<Drink>? drinks}) {
    this.user = user ?? UserSetup();
    this.drinks = drinks ?? <Drink>[];
  }

  DrinkListState copyWith({List<Drink>? drinks, UserSetup? user}) {
    return DrinkListState(
      user: user ?? this.user,
      drinks: drinks ?? this.drinks,
    );
  }
}

class DrinkListInitialState extends DrinkListState {
  DrinkListInitialState()
      : super(
          user: UserSetup(),
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
