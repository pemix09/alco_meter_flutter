import 'dart:convert';

import 'package:alco_meter_flutter/data/enums/sex.dart';

class UserSetup {
  late double height;
  late double weight;
  late Sex sex;

  UserSetup({double? height, double? weight, Sex? sex}) {
    this.height = height ?? 0;
    this.weight = weight ?? 0;
    this.sex = sex ?? Sex.male;
  }

  set userHeight(double userHeight) {
    height = userHeight;
  }

  set userWeight(double userWeight) {
    weight = userWeight;
  }

  set userSex(Sex userSex) {
    sex = userSex;
  }

  String toJson() { 
    var jsonMap = {
        'height': height,
        'weight': weight,
        'sex': sex.name
      };
    return jsonEncode(jsonMap);
  }

  static UserSetup fromJson(String jsonString) {
    var map = jsonDecode(jsonString);
    return UserSetup(
      height: map['height'],
      weight: map['weight'],
      sex: Sex.values.firstWhere((el) => el.name == map['sex']),
    );
  }
}
