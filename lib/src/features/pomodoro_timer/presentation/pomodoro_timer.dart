import 'package:flutter/material.dart';
import 'package:pomodoro_timer_ui/src/data/database_repository.dart';
import 'package:pomodoro_timer_ui/src/features/pomodoro_timer/domain/pomodoro_widget.dart';
import 'package:audioplayers/audioplayers.dart';

// ignore: must_be_immutable
class PomodoroTimer extends StatelessWidget {
  final DatabaseRepository db;
  AudioPlayer player = AudioPlayer();
  PomodoroTimer({super.key, required this.db});

  Future<void> playSound() async {
    player.setVolume(1);
    await player.play(AssetSource("audio/bell.wav"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text("Pomodoro Timer", style: TextStyle(fontSize: 28)),
          ),
          Expanded(
            child: PomodoroWidget(
              time: db.readTask(0) != null ? db.readTask(0)!.time : 0,
              title: db.readTask(0) != null ? db.readTask(0)!.title : "",
              onFinished: () async {
                await playSound();
              },
            ),
          ),
        ],
      ),
    );
  }
}
