import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/routine.dart';
import '../providers/routine_provider.dart';

class EditRoutineScreen extends StatefulWidget {
  final Routine routine;
  const EditRoutineScreen({Key? key, required this.routine}) : super(key: key);

  @override
  State<EditRoutineScreen> createState() => _EditRoutineScreenState();
}

class _EditRoutineScreenState extends State<EditRoutineScreen> {
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late DateTime _selectedDate;
  late List<String> _selectedDays;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.routine.name);
    _categoryController = TextEditingController(text: widget.routine.category);
    _selectedDate = widget.routine.date;
    _selectedDays = List.from(widget.routine.days);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Provider.of<RoutineProvider>(context, listen: false).updateRoutine(
      widget.routine.id,
      name: _nameController.text,
      category: _categoryController.text,
      date: _selectedDate,
      days: _selectedDays,
    );
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
      appBar: AppBar(title: Text('루틴 수정')),
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
                child: Text('수정 완료'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
