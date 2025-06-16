import 'package:flutter/material.dart';
import '../models/routine.dart';

class RoutineProvider extends ChangeNotifier {
  final List<Routine> _routines = [];

  List<Routine> get routines => [..._routines];

  void addRoutine(Routine routine) {
    _routines.add(routine);
    notifyListeners();
  }

  void updateRoutine(String id, Routine newRoutine) {
    final index = _routines.indexWhere((routine) => routine.id == id);
    if (index != -1) {
      _routines[index] = newRoutine;
      notifyListeners();
    }
  }

  void deleteRoutine(String id) {
    _routines.removeWhere((routine) => routine.id == id);
    notifyListeners();
  }

  void toggleComplete(Routine routine) {
    final index = _routines.indexOf(routine);
    if (index != -1) {
      _routines[index].isCompleted = !_routines[index].isCompleted;
      notifyListeners();
    }
  }

  List<Routine> routinesForDay(String weekday) {
    return _routines.where((routine) => routine.days.contains(weekday)).toList();
  }
}
