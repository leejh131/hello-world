import 'package:flutter/material.dart';
import '../models/routine.dart';

class RoutineProvider with ChangeNotifier {
  final List<Routine> _routines = [];

  List<Routine> get routines => [..._routines];

  void addRoutine(Routine routine) {
    _routines.add(routine);
    notifyListeners();
  }

  void updateRoutine(String id, String name, DateTime date, String time) {
    final index = _routines.indexWhere((r) => r.id == id);
    if (index != -1) {
      _routines[index] = Routine(
        id: id,
        name: name,
        date: date,
        time: time,
        isCompleted: _routines[index].isCompleted,
      );
      notifyListeners();
    }
  }

  void toggleComplete(String id) {
    final index = _routines.indexWhere((r) => r.id == id);
    if (index != -1) {
      _routines[index].isCompleted = !_routines[index].isCompleted;
      notifyListeners();
    }
  }

  void deleteRoutine(String id) {
    _routines.removeWhere((r) => r.id == id);
    notifyListeners();
  }
}