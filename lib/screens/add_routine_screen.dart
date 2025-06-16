import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/routine.dart';
import '../providers/routine_provider.dart';

class AddRoutineScreen extends StatefulWidget {
  @override
  _AddRoutineScreenState createState() => _AddRoutineScreenState();
}

class _AddRoutineScreenState extends State<AddRoutineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _setsController = TextEditingController();
  final _repsController = TextEditingController();
  final List<String> _selectedDays = [];
  final List<String> _weekdays = ['월', '화', '수', '목', '금', '토', '일'];

  void _saveRoutine() {
    if (_formKey.currentState!.validate() && _selectedDays.isNotEmpty) {
      final newRoutine = Routine(
        id: const Uuid().v4(),
        name: _nameController.text,
        category: _categoryController.text,
        days: _selectedDays,
        sets: int.tryParse(_setsController.text) ?? 0,
        reps: int.tryParse(_repsController.text) ?? 0,
      );
      Provider.of<RoutineProvider>(context, listen: false).addRoutine(newRoutine);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('루틴 추가')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: '루틴 이름'),
                validator: (value) => value!.isEmpty ? '값을 입력하세요' : null,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: '부위'),
                validator: (value) => value!.isEmpty ? '값을 입력하세요' : null,
              ),
              TextFormField(
                controller: _setsController,
                decoration: InputDecoration(labelText: '세트 수'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? '값을 입력하세요' : null,
              ),
              TextFormField(
                controller: _repsController,
                decoration: InputDecoration(labelText: '회당 반복 횟수'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? '값을 입력하세요' : null,
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
                onPressed: _saveRoutine,
                child: Text('저장하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
