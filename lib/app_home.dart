import 'package:flutter/material.dart';
import 'package:pomodoro_timer_ui/features/timer_page/presentation/timer_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pomodoro Timer UI",
      routes: {"/timerPage": (context) => TimerPage()},
      initialRoute: "/timerPage",
    );
  }
}
