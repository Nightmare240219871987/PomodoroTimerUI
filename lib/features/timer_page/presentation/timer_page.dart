import 'package:flutter/material.dart';
import 'package:pomodoro_timer_ui/features/timer_page/domain/pomodoro_timer_widget.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = "Pomodoro Timer UI";
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              PomodoroTimerWidget(
                time: 1,
                title:
                    "fiktive Aufgabe zum testen und das kann auch ein ziehmlich langer Text sein.",
                onFinished: () {},
                onCancel: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
