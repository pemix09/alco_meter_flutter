import 'package:alco_meter_flutter/data/enums/drink_type.dart';

abstract class DrinkEvent {}

class DrinkTypeChangedEvent extends DrinkEvent {
  final DrinkType drinkType;

  DrinkTypeChangedEvent(this.drinkType);
}

class DrinkVolumeChangedEvent extends DrinkEvent {
  final double drinkVolume;

  DrinkVolumeChangedEvent(this.drinkVolume);
}

class DrinkPercentageChangedEvent extends DrinkEvent {
  final double drinkPercentage;

  DrinkPercentageChangedEvent(this.drinkPercentage);
}

class AddDrinkEvent extends DrinkEvent {}