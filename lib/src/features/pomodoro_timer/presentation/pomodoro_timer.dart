import 'package:flutter/material.dart';
import 'package:pomodoro_timer_ui/src/data/database_repository.dart';

class PomodoroTimer extends StatelessWidget {
  final DatabaseRepository db;
  const PomodoroTimer({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Text("Pomodoro Timer"));
  }
}
