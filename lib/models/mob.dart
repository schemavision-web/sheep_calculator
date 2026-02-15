import 'package:isar/isar.dart';

part 'mob.g.dart';

@collection
class Mob {
  Id id = Isar.autoIncrement;

  late String name;
  late int numberOfSheep;
  late double weight;
  late double rationKg;
}
