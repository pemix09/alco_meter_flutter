import 'package:hive/hive.dart';

part 'sex.g.dart';

@HiveType(typeId: 2)
enum Sex {
  @HiveField(0)
  male,

  @HiveField(1)
  female
}