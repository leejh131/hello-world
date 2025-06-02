import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

class Routine {
  final String id;
  String name;
  String category;
  bool isCompleted;
  DateTime date;
  List<String> days;

  Routine({
    required this.id,
    required this.name,
    required this.category,
    required this.date,
    required this.days,
    this.isCompleted = false,
  });

  void toggleComplete() {
    isCompleted = !isCompleted;
  }
}
