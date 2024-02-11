import 'package:alco_meter_flutter/app/data/enums/drink_type.dart';
import 'package:hive/hive.dart';

part 'drink.g.dart';

@HiveType(typeId: 0)
class Drink {
  @HiveField(0)
  final double amount;

  @HiveField(1)
  final double percentage;

  @HiveField(2)
  final DrinkType type;

  @HiveField(3)
  final DateTime timeAdded;

  @HiveField(4)
  final String id;

  Drink({
    required this.amount,
    required this.percentage,
    required this.type,
    required this.timeAdded,
    required this.id,
  });
}