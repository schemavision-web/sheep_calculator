import 'package:flutter/material.dart';
import '../models/mob.dart';
import '../services/db.dart';
import 'mob_form_screen.dart';

class MobViewScreen extends StatelessWidget {
  final Mob mob;

  const MobViewScreen({super.key, required this.mob});

  Future<void> _delete(BuildContext context) async {
    await mob.delete();
    Navigator.pop(context, true);

    if (context.mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mob.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final changed = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MobFormScreen(existing: mob),
                ),
              );
              if (changed == true && context.mounted) Navigator.pop(context, true);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _delete(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${mob.name}", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text("Sheep: ${mob.numberOfSheep}"),
            Text("Average Weight: ${mob.weight} kg"),
            Text("Daily Ration (${mob.rationType}): ${mob.rationKg} kg"),
            Text("Total Daily Ration ${mob.rationType}: ${mob.totalDailyRation} kg"),
          ],
        ),
      ),
    );
  }
}
