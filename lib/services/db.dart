import 'package:hive_flutter/hive_flutter.dart';
import '../models/mob.dart';

class DB {
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();
    Hive.registerAdapter(MobAdapter());

    await Hive.openBox<Mob>('mobs');

    _initialized = true;
  }

  static Box<Mob> get mobsBox => Hive.box<Mob>('mobs');
}
