import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/routine_provider.dart';
import '../screens/add_routine_screen.dart';
import '../screens/edit_routine_screen.dart';
import '../models/routine.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> weekdays = ['월', '화', '수', '목', '금', '토', '일'];
  final List<String> weekdayKeys = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: weekdays.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routineProvider = Provider.of<RoutineProvider>(context);
    final today = DateFormat('yyyy년 MM월 dd일').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text('루틴 홈'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: weekdays.map((day) => Tab(text: day)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(weekdayKeys.length, (index) {
          final dayKey = weekdayKeys[index];
          final routines = routineProvider.routinesForDay(dayKey);
          final completedCount = routines.where((r) => r.isCompleted).length;
          final progress = routines.isEmpty ? 0.0 : completedCount / routines.length;

          return Column(
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
                            Text('$dayKey요일 루틴: ${routines.length}개'),
                            Text('완료된 루틴: $completedCount개'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: routines.isEmpty
                    ? const Center(child: Text('등록된 루틴이 없습니다'))
                    : ListView.builder(
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
                          subtitle: Text('부위: ${routine.category}\n세트: ${routine.sets} x ${routine.reps}회'),
                          isThreeLine: true,
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
          );
        }),
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
