import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const SheepCalculatorApp());
}

class SheepCalculatorApp extends StatelessWidget {
  const SheepCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sheep Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
