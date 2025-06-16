import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/routine.dart';
import '../providers/routine_provider.dart';
import '../screens/edit_routine_screen.dart';

class RoutineTile extends StatelessWidget {
  final Routine routine;

  const RoutineTile({Key? key, required this.routine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${routine.name} - ${routine.time}'),
      subtitle: Text('반복 요일: ${routine.days.join(', ')}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: routine.isCompleted,
            onChanged: (_) {
              Provider.of<RoutineProvider>(context, listen: false)
                  .toggleCompletion(routine.id);
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditRoutineScreen(routine: routine),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<RoutineProvider>(context, listen: false)
                  .deleteRoutine(routine.id);
            },
          ),
        ],
      ),
    );
  }
}
