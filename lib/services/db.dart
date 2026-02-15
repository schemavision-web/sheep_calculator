import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/mob.dart';

class DB {
  static Isar? _instance;

  static Future<Isar> get instance async {
    if (_instance != null) return _instance!;

    // On web, Isar handles storage automatically.
    if (Isar.instanceNames.isNotEmpty) {
      _instance = Isar.getInstance()!;
      return _instance!;
    }

    final dir = await getApplicationDocumentsDirectory();

    _instance = await Isar.open(
      [MobSchema],
      directory: dir.path,
    );

    return _instance!;
  }
}
