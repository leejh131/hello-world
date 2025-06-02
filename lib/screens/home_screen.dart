import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/routine_provider.dart';
import '../screens/add_routine_screen.dart';
import '../screens/edit_routine_screen.dart';
import '../models/routine.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routineProvider = Provider.of<RoutineProvider>(context);
    final routines = routineProvider.routines;
    final completedCount = routines.where((r) => r.isCompleted).length;
    final progress = routines.isEmpty ? 0.0 : completedCount / routines.length;
    final today = DateFormat('yyyy년 MM월 dd일').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text('루틴 홈'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircularPercentIndicator(
                      radius: 60.0,
                      lineWidth: 8.0,
                      percent: progress,
                      center: Text("${(progress * 100).toInt()}%"),
                      progressColor: Colors.teal,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(today, style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text('전체 루틴: ${routines.length}개'),
                        Text('완료된 루틴: $completedCount개'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: routines.length,
              itemBuilder: (context, index) {
                final routine = routines[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.fitness_center, color: Colors.white),
                      ),
                      title: Text(routine.name),
                      subtitle: Text('카테고리: ${routine.category}'),
                      trailing: Checkbox(
                        value: routine.isCompleted,
                        onChanged: (_) {
                          routineProvider.toggleComplete(routine);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => EditRoutineScreen(routine: routine),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => AddRoutineScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
