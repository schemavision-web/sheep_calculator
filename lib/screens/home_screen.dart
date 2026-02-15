import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../services/db.dart';
import '../models/mob.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Mob> mobs = [];

  @override
  void initState() {
    super.initState();
    _loadMobs();
  }

  Future<void> _loadMobs() async {
    final isar = await DB.instance;
    final results = await isar.mobs.where().findAll();
    setState(() => mobs = results);
  }

  Future<void> _addMob() async {
    final isar = await DB.instance;

    final mob = Mob()
      ..name = "New Mob"
      ..numberOfSheep = 50
      ..weight = 60.0
      ..rationKg = 1.5;

    await isar.writeTxn(() async {
      await isar.mobs.put(mob);
    });

    _loadMobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sheep Calculator")),
      body: ListView.builder(
        itemCount: mobs.length,
        itemBuilder: (context, index) {
          final mob = mobs[index];
          return ListTile(
            title: Text(mob.name),
            subtitle: Text(
              "${mob.numberOfSheep} sheep • ${mob.weight} kg • ${mob.rationKg} kg ration",
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMob,
        child: const Icon(Icons.add),
      ),
    );
  }
}
