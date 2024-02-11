import 'package:hive/hive.dart';

part 'drink_type.g.dart';

@HiveType(typeId: 3)
enum DrinkType {
  @HiveField(0)
  beer, 

  @HiveField(1)
  wine,

  @HiveField(2)
  vodka
}