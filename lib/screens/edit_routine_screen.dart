import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/routine.dart';
import '../providers/routine_provider.dart';

class EditRoutineScreen extends StatefulWidget {
  final Routine routine;
  EditRoutineScreen({required this.routine});

  @override
  _EditRoutineScreenState createState() => _EditRoutineScreenState();
}

class _EditRoutineScreenState extends State<EditRoutineScreen> {
  late TextEditingController _nameController;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.routine.name);
    _selectedDate = widget.routine.date;
    _selectedTime = _parseTime(widget.routine.time);
  }

  void _submit() {
    if (_nameController.text.isEmpty || _selectedDate == null || _selectedTime == null) return;

    final timeString = '${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}';

    Provider.of<RoutineProvider>(context, listen: false).updateRoutine(
      widget.routine.id,
      _nameController.text,
      _selectedDate!,
      timeString,
    );
    Navigator.pop(context);
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
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
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  TimeOfDay _parseTime(String timeString) {
    try {
      final parts = timeString.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    } catch (_) {
      return TimeOfDay.now();
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
      appBar: AppBar(title: Text('루틴 수정')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: '운동 이름')),
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
              child: Text('수정 완료'),
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 48)),
            ),
          ],
        ),
      ),
    );
  }
}