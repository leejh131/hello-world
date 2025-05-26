import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/routine_provider.dart';
import '../widgets/routine_tile.dart';
import 'add_routine_screen.dart';
import 'edit_routine_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routines = Provider.of<RoutineProvider>(context).routines;

    return Scaffold(
      appBar: AppBar(
        title: Text('운동 루틴'),
        actions: [
          IconButton(
            icon: Icon(Icons.pie_chart),
            onPressed: () => Navigator.pushNamed(context, '/progress'),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: routines.length,
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EditRoutineScreen(routine: routines[i]),
            ),
          ),
          child: RoutineTile(routine: routines[i]),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'calendar',
            child: Icon(Icons.calendar_today),
            onPressed: () => Navigator.pushNamed(context, '/calendar'),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'add',
            child: Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddRoutineScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
