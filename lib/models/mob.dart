import 'package:hive/hive.dart';

part 'mob.g.dart';

@HiveType(typeId: 0)
class Mob extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int numberOfSheep;

  @HiveField(2)
  double weight;

  @HiveField(3)
  double rationKg;

  Mob({
    required this.name,
    required this.numberOfSheep,
    required this.weight,
    required this.rationKg,
  });

  double get totalDailyRation => numberOfSheep * rationKg;
}
