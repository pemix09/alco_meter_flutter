import 'package:alco_meter_flutter/app/data/enums/sex.dart';

abstract class UserSetupEvent {}

class WeightEnteredEvent extends UserSetupEvent {
  late final double weight;

  WeightEnteredEvent({required double userWeight}) {
    weight = userWeight;
  }
}
class HeightEnteredEvent extends UserSetupEvent {
  late final double height;

  HeightEnteredEvent({required double userHeight}) {
    height = userHeight;
  }
}
class SexEnteredEvent extends UserSetupEvent {
  late final Sex sex;

  SexEnteredEvent({required Sex userSex}) {
    sex = userSex;
  }
}
class UserConfigFinishedEvent extends UserSetupEvent {}