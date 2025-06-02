import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/routine_provider.dart';
import '../models/routine.dart';

class AddRoutineScreen extends StatefulWidget {
  @override
  _AddRoutineScreenState createState() => _AddRoutineScreenState();
}

class _AddRoutineScreenState extends State<AddRoutineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  List<String> _selectedDays = [];

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final newRoutine = Routine(
      id: Uuid().v4(),
      name: _nameController.text,
      category: _categoryController.text,
      date: _selectedDate,
      days: _selectedDays,
    );

    Provider.of<RoutineProvider>(context, listen: false).addRoutine(newRoutine);
    Navigator.of(context).pop();
  }

  void _toggleDay(String day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
      } else {
        _selectedDays.add(day);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final daysOfWeek = ['월', '화', '수', '목', '금', '토', '일'];

    return Scaffold(
      appBar: AppBar(title: Text('루틴 추가')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: '루틴 이름'),
                validator: (value) => value == null || value.isEmpty ? '이름을 입력하세요' : null,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: '카테고리'),
              ),
              SizedBox(height: 16),
              Text('시작 날짜: ${_selectedDate.toLocal().toString().split(' ')[0]}'),
              ElevatedButton(
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
                child: Text('날짜 선택'),
              ),
              SizedBox(height: 16),
              Text('반복 요일'),
              Wrap(
                spacing: 8,
                children: daysOfWeek.map((day) {
                  final selected = _selectedDays.contains(day);
                  return FilterChip(
                    label: Text(day),
                    selected: selected,
                    onSelected: (_) => _toggleDay(day),
                  );
                }).toList(),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: Text('추가하기'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
