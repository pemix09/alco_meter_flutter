import 'package:alco_meter_flutter/data/enums/sex.dart';

class UserSetup {
  double? height;
  double? weight;
  Sex? sex;

  set userHeight(double? userHeight) {
    height = userHeight;
  }
  set userWeight(double? userWeight) {
    weight = userWeight;
  }
  set userSex(Sex? userSex) {
    sex = userSex;
  }
}