import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../providers/routine_provider.dart';
import '../models/routine.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final routines = Provider.of<RoutineProvider>(context).routines;

    List<Routine> getRoutinesForDay(DateTime day) {
      return routines.where((r) => isSameDay(r.date, day)).toList();
    }

    return Scaffold(
      appBar: AppBar(title: Text('캘린더 보기')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            locale: 'ko_KR',
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              selectedDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
            ),
          ),
          Expanded(
            child: ListView(
              children: getRoutinesForDay(_selectedDay ?? _focusedDay)
                  .map((r) => ListTile(
                title: Text(r.name),
                subtitle: Text('${DateFormat.Hm().format(DateFormat('HH:mm').parse(r.time))} - ${DateFormat.yMMMMEEEEd('ko_KR').format(r.date)}'),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
