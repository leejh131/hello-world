import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../models/routine.dart';
import '../providers/routine_provider.dart';

class AddRoutineScreen extends StatefulWidget {
  @override
  _AddRoutineScreenState createState() => _AddRoutineScreenState();
}

class _AddRoutineScreenState extends State<AddRoutineScreen> {
  final _nameController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _submit() {
    if (_nameController.text.isEmpty || _selectedDate == null || _selectedTime == null) return;

    final timeString = '${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}';

    final routine = Routine(
      id: Uuid().v4(),
      name: _nameController.text,
      date: _selectedDate!,
      time: timeString,
    );

    Provider.of<RoutineProvider>(context, listen: false).addRoutine(routine);
    Navigator.pop(context);
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      locale: const Locale('ko', 'KR'),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateLabel = _selectedDate == null
        ? '날짜 선택'
        : DateFormat.yMMMMd('ko_KR').format(_selectedDate!);
    final timeLabel = _selectedTime == null
        ? '시간 선택'
        : _selectedTime!.format(context);

    return Scaffold(
      appBar: AppBar(title: Text('루틴 추가')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '운동 이름'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickDate,
              icon: Icon(Icons.calendar_today),
              label: Text(dateLabel),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _pickTime,
              icon: Icon(Icons.access_time),
              label: Text(timeLabel),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _submit,
              child: Text('등록'),
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 48)),
            ),
          ],
        ),
      ),
    );
  }
}