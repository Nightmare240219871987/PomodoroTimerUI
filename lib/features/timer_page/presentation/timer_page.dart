import 'package:flutter/material.dart';
import 'package:pomodoro_timer_ui/common/task.dart';
import 'package:pomodoro_timer_ui/data/database_repo.dart';
import 'package:pomodoro_timer_ui/features/add_page/presentation/add_page.dart';
import 'package:pomodoro_timer_ui/features/timer_page/domain/pomodoro_timer_widget.dart';
import "package:audioplayers/audioplayers.dart";

// ignore: must_be_immutable
class TimerPage extends StatefulWidget {
  DatabaseRepo db;
  TimerPage({super.key, required this.db});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final AudioPlayer _player = AudioPlayer();

  Future<void> _playAudio() async {
    String audioPath = "tones/bell.wav";
    _player.setVolume(1);
    await _player.play(AssetSource(audioPath));
  }

  @override
  Widget build(BuildContext context) {
    const String title = "Pomodoro Timer UI";
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            PomodoroTimerWidget(
              time: widget.db.readTimeFromIndex(0) ?? 0,
              title: widget.db.readTaskTitleFromIndex(0) ?? "",
              onFinished: () {
                _playAudio();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("wurde die Aufgabe beendet?"),
                      content: const Text(
                        "Wenn die Aufgabe beendet wurde, drücken Sie auf Ja. Wenn nicht drücken Sie auf nein.",
                      ),
                      actions: [
                        TextButton(
                          child: Text("Ja"),
                          onPressed: () {
                            setState(() {
                              widget.db.deleteTask(0);
                            });
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text("Nein"),
                          onPressed: () {
                            setState(() {
                              widget.db.readTasks().insert(
                                0,
                                Task(taskTitle: "Pause", timeMin: 5),
                              );
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              onCancel: () {},
            ),
            Text(
              "ToDo Liste",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 415,
              child: ListView.builder(
                itemCount: widget.db.readTasks().length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Text(widget.db.readTaskTitleFromIndex(index)!),
                      trailing: Text(
                        "${widget.db.readTimeFromIndex(index)} Min",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.timer),
            label: "Pomodoro Timer",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: "Einstellungen",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddPage(
                onAdd: (Task t) {
                  setState(() {
                    widget.db.createTask(t);
                  });
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
