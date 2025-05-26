class Routine {
  final String id;
  final String name;
  final DateTime date;
  final String time;
  bool isCompleted;

  Routine({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    this.isCompleted = false,
  });
}