import 'dart:convert';
import 'package:alco_meter_flutter/app/data/enums/sex.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  late double height;

  @HiveField(1)
  late double weight;

  @HiveField(2)
  late Sex sex;

  @HiveField(3)
  late String id;

  User({required double this.height, required double this.weight,
  required Sex this.sex, required String this.id});

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
        'sex': sex.name,
        'id': id,
      };
    return jsonEncode(jsonMap);
  }

  static User fromJson(String jsonString) {
    var map = jsonDecode(jsonString);
    return User(
      height: map['height'],
      weight: map['weight'],
      sex: Sex.values.firstWhere((el) => el.name == map['sex']),
      id: map['id'],
    );
  }
}
