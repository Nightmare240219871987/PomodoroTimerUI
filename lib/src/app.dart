import 'package:flutter/material.dart';
import 'package:pomodoro_timer_ui/src/data/database_repository.dart';
import 'package:pomodoro_timer_ui/src/features/landing_page/presentation/landing_page.dart';

class MainApp extends StatelessWidget {
  final DatabaseRepository db;
  const MainApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pomodoro Timer",
      home: LandingPage(db: db, currentIndex: 0),
    );
  }
}
