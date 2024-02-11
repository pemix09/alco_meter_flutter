import 'package:alco_meter_flutter/app/data/enums/drink_type.dart';

class AddDrinkState {
  DrinkType drinkType;
  double percentage;
  double volume;

  AddDrinkState({
    required this.drinkType,
    required this.percentage,
    required this.volume,
  });

  AddDrinkState copyWith({
    DrinkType? drinkType,
    double? percentage,
    double? volume,
  }) {
    return AddDrinkState(
      drinkType: drinkType ?? this.drinkType,
      percentage: percentage ?? this.percentage,
      volume: volume ?? this.volume,
    );
  }
}

class AddDrinkInitialState extends AddDrinkState {
  AddDrinkInitialState()
      : super(
          drinkType: DrinkType.beer,
          percentage: 5,
          volume: 500,
        );

}

class DrinkTypeChangedState extends AddDrinkState {
  DrinkTypeChangedState({required super.drinkType, required super.percentage, required super.volume});

}

class DrinkPercentageChangedState extends AddDrinkState {
  DrinkPercentageChangedState({required super.drinkType, required super.percentage, required super.volume});
  
}

class DrinkVolumeChangedState extends AddDrinkState {
  DrinkVolumeChangedState({required super.drinkType, required super.percentage, required super.volume});
  
}

class DrinkAddedState extends AddDrinkInitialState {
  DrinkAddedState() : super();
}
