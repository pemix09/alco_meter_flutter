import 'package:alco_meter_flutter/data/enums/drink_type.dart';
import 'package:uuid/uuid.dart';

class Drink {
  final double amount;
  final double percentage;
  final DrinkType type;
  final DateTime timeAdded;
  late final Uuid id;
  String? photoPath;

  Drink({
    required this.amount,
    required this.percentage,
    required this.type,
    required this.timeAdded
  }) {
    id = const Uuid();
  }
}