import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/routine.dart';
import '../providers/routine_provider.dart';

class EditRoutineScreen extends StatefulWidget {
  final Routine routine;

  const EditRoutineScreen({required this.routine});

  @override
  _EditRoutineScreenState createState() => _EditRoutineScreenState();
}

class _EditRoutineScreenState extends State<EditRoutineScreen> {
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _setsController;
  late TextEditingController _repsController;
  late List<String> _selectedDays;
  final List<String> _weekdays = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.routine.name);
    _categoryController = TextEditingController(text: widget.routine.category);
    _setsController = TextEditingController(text: widget.routine.sets.toString());
    _repsController = TextEditingController(text: widget.routine.reps.toString());
    _selectedDays = List.from(widget.routine.days);
  }

  void _updateRoutine() {
    final updatedRoutine = Routine(
      id: widget.routine.id,
      name: _nameController.text,
      category: _categoryController.text,
      isCompleted: widget.routine.isCompleted,
      days: _selectedDays,
      sets: int.tryParse(_setsController.text) ?? 0,
      reps: int.tryParse(_repsController.text) ?? 0,
    );
    Provider.of<RoutineProvider>(context, listen: false).updateRoutine(widget.routine.id, updatedRoutine);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('루틴 수정')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '루틴 이름'),
            ),
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: '부위'),
            ),
            TextFormField(
              controller: _setsController,
              decoration: InputDecoration(labelText: '세트 수'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _repsController,
              decoration: InputDecoration(labelText: '회당 반복 횟수'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Text('반복 요일 선택', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: _weekdays.map((day) {
                return FilterChip(
                  label: Text(day),
                  selected: _selectedDays.contains(day),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedDays.add(day);
                      } else {
                        _selectedDays.remove(day);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: _updateRoutine,
              child: Text('수정하기'),
            ),
          ],
        ),
      ),
    );
  }
}
