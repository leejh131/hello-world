import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../providers/routine_provider.dart';

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RoutineProvider>(context);
    final total = provider.routines.length;
    final completed = provider.routines.where((r) => r.isCompleted).length;
    final percent = total == 0 ? 0.0 : completed / total;

    return Scaffold(
      appBar: AppBar(title: Text('진행률 확인')),
      body: Center(
        child: CircularPercentIndicator(
          radius: 120.0,
          lineWidth: 13.0,
          animation: true,
          percent: percent,
          center: Text("${(percent * 100).toStringAsFixed(1)}% 완료"),
          progressColor: Colors.green,
        ),
      ),
    );
  }
}
