import 'package:flutter/material.dart';
import 'package:pomodoro_timer_ui/data/database_repo.dart';
import 'package:pomodoro_timer_ui/data/mock_database.dart';
import 'package:pomodoro_timer_ui/features/timer_page/presentation/timer_page.dart';
import 'package:pomodoro_timer_ui/themes/theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseRepo db = MockDatabase();
    return MaterialApp(
      title: "Pomodoro Timer UI",
      theme: lightMode,
      routes: {"/timerPage": (context) => TimerPage(db: db)},
      initialRoute: "/timerPage",
    );
  }
}
