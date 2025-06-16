import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/routine.dart';
import '../providers/routine_provider.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Routine> _getRoutinesForDay(DateTime day, List<Routine> routines) {
    final dayStr = _dayToWeekdayString(day);
    return routines.where((r) => r.days.contains(dayStr)).toList();
  }

  String _dayToWeekdayString(DateTime date) {
    final weekday = date.weekday;
    switch (weekday) {
      case DateTime.monday:
        return '월';
      case DateTime.tuesday:
        return '화';
      case DateTime.wednesday:
        return '수';
      case DateTime.thursday:
        return '목';
      case DateTime.friday:
        return '금';
      case DateTime.saturday:
        return '토';
      case DateTime.sunday:
        return '일';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final routines = Provider.of<RoutineProvider>(context).routines;
    final selectedDate = _selectedDay ?? _focusedDay;
    final selectedRoutines = _getRoutinesForDay(selectedDate, routines);

    return Scaffold(
      appBar: AppBar(title: Text('루틴 캘린더')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.teal.shade200,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: selectedRoutines.length,
              itemBuilder: (context, index) {
                final r = selectedRoutines[index];
                return ListTile(
                  leading: Icon(Icons.check_circle_outline, color: Colors.teal),
                  title: Text(r.name),
                  subtitle: Text('반복 요일: ${r.days.join(', ')}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
