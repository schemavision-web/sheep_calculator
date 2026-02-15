import 'package:flutter/material.dart';
import '../services/db.dart';
import '../models/mob.dart';
import 'mob_form_screen.dart';
import 'mob_view_screen.dart';

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
    final box = DB.mobsBox;
    setState(() => mobs = box.values.toList());
  }

  Future<void> _addMob() async {
    final changed = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MobFormScreen()),
    );

    if (changed == true) _loadMobs();
  }


  Future<void> _openMob(Mob mob) async {
    final changed = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MobViewScreen(mob: mob)),
    );

    if (changed == true) _loadMobs();
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
            subtitle: Text("${mob.numberOfSheep} sheep"),
            onTap: () => _openMob(mob),
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
