import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/routine.dart';
import '../providers/routine_provider.dart';
import '../screens/edit_routine_screen.dart';

class RoutineTile extends StatelessWidget {
  final Routine routine;

  RoutineTile({required this.routine});

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('삭제 확인'),
        content: Text('${routine.name} 루틴을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            child: Text('취소'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: Text('삭제', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Provider.of<RoutineProvider>(context, listen: false).deleteRoutine(routine.id);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${routine.name} - ${routine.time}'),
      subtitle: Text(DateFormat.yMMMMEEEEd('ko_KR').format(routine.date)),
      trailing: Checkbox(
        value: routine.isCompleted,
        onChanged: (_) => Provider.of<RoutineProvider>(context, listen: false).toggleComplete(routine.id),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => EditRoutineScreen(routine: routine)),
      ),
      onLongPress: () => _confirmDelete(context),
    );
  }
}
