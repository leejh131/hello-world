import 'package:flutter/material.dart';

class Routine {
  final String id;
  final String name;
  final String category;
  bool isCompleted;
  final List<String> days; // ['Mon', 'Tue', ...]
  final int sets;
  final int reps;

  Routine({
    required this.id,
    required this.name,
    required this.category,
    this.isCompleted = false,
    required this.days,
    required this.sets,
    required this.reps,
  });
}
