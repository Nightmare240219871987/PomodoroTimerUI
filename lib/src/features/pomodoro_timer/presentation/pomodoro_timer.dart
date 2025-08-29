import 'package:flutter/material.dart';
import 'package:pomodoro_timer_ui/src/common/task.dart';
import 'package:pomodoro_timer_ui/src/data/database_repository.dart';
import 'package:pomodoro_timer_ui/src/features/pomodoro_timer/domain/pomodoro_widget.dart';
import 'package:audioplayers/audioplayers.dart';

// ignore: must_be_immutable
class PomodoroTimer extends StatefulWidget {
  final DatabaseRepository db;

  const PomodoroTimer({super.key, required this.db});

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  AudioPlayer player = AudioPlayer();

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
              time: widget.db.readTask(0) != null
                  ? widget.db.readTask(0)!.time
                  : 0,
              title: widget.db.readTask(0) != null
                  ? widget.db.readTask(0)!.title
                  : "",
              onFinished: () async {
                await playSound();
                showDialog<void>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("abgeschlossen ?"),
                      content: Text("Wurde der Tasks abgeschlossen ?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              widget.db.insertTask(
                                0,
                                Task(title: "Pause", time: 5),
                              );
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text("Nein"),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              widget.db.removeTask(0);
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text("Ja"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
