import 'package:flutter/material.dart';
import '../models/mob.dart';
import '../services/db.dart';

class MobFormScreen extends StatefulWidget {
  final Mob? existing;

  const MobFormScreen({super.key, this.existing});

  @override
  State<MobFormScreen> createState() => _MobFormScreenState();
}

class _MobFormScreenState extends State<MobFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late int numberOfSheep;
  late double weight;
  late double rationKg;
  late String? rationType;
  late final rationTypes = ['Hay', 'Pellets', 'Pasture'];

  @override
  void initState() {
    super.initState();

    final mob = widget.existing;
    name = mob?.name ?? '';
    numberOfSheep = mob?.numberOfSheep ?? 0;
    weight = mob?.weight ?? 0.0;
    rationKg = mob?.rationKg ?? 0.0;
    rationType = mob?.rationType;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    final box = DB.mobsBox;

    if (widget.existing == null) {
      final mob = Mob(
        name: name,
        numberOfSheep: numberOfSheep,
        weight: weight,
        rationKg: rationKg,
        rationType: rationType!
      );
      await box.add(mob);
    } else {
      widget.existing!
        ..name = name
        ..numberOfSheep = numberOfSheep
        ..weight = weight
        ..rationKg = rationKg;
      await widget.existing!.save();
    }

    if (mounted) Navigator.pop(context, true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existing == null ? "Add Mob" : "Edit Mob"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: "Name"),
                onSaved: (v) => name = v!.trim(),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                initialValue: numberOfSheep.toString(),
                decoration: const InputDecoration(labelText: "Number of Sheep"),
                keyboardType: TextInputType.number,
                onSaved: (v) => numberOfSheep = int.parse(v!),
              ),
              TextFormField(
                initialValue: weight.toString(),
                decoration: const InputDecoration(labelText: "Average Weight (kg)"),
                keyboardType: TextInputType.number,
                onSaved: (v) => weight = double.parse(v!),
              ),
              TextFormField(
                initialValue: rationKg.toString(),
                decoration: const InputDecoration(labelText: "Daily Ration Per Sheep (kg)"),
                keyboardType: TextInputType.number,
                onSaved: (v) => rationKg = double.parse(v!),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Ration Type'),
                initialValue: rationType,
                items: rationTypes
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => rationType = value);
                },
                validator: (value) =>
                    value == null ? 'Please select a ration type' : null,
              ),

              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _save,
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
