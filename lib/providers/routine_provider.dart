import 'package:flutter/foundation.dart';
import '../models/routine.dart';

class RoutineProvider with ChangeNotifier {
  final List<Routine> _routines = [];

  List<Routine> get routines => [..._routines];

  void addRoutine(Routine routine) {
    _routines.add(routine);
    notifyListeners();
  }

  void updateRoutine(String id, {
    required String name,
    required String category,
    required DateTime date,
    required List<String> days,
  }) {
    final index = _routines.indexWhere((r) => r.id == id);
    if (index != -1) {
      _routines[index].name = name;
      _routines[index].category = category;
      _routines[index].date = date;
      _routines[index].days = days;
      notifyListeners();
    }
  }

  void deleteRoutine(String id) {
    _routines.removeWhere((r) => r.id == id);
    notifyListeners();
  }

  void toggleComplete(Routine routine) {
    routine.toggleComplete();
    notifyListeners();
  }

  Routine? findById(String id) {
    final index = _routines.indexWhere((r) => r.id == id);
    if (index == -1) return null;
    return _routines[index];
  }
}
