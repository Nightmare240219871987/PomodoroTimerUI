import 'package:flutter/material.dart';
import 'package:pomodoro_timer_ui/src/common/task.dart';
import 'package:pomodoro_timer_ui/src/data/database_repository.dart';
import 'package:pomodoro_timer_ui/src/features/pomodoro_timer/presentation/pomodoro_timer.dart';
import 'package:pomodoro_timer_ui/src/features/tasks/presentation/add_task.dart';
import 'package:pomodoro_timer_ui/src/features/tasks/presentation/tasks.dart';

// ignore: must_be_immutable
class LandingPage extends StatefulWidget {
  final DatabaseRepository db;
  int currentIndex;
  LandingPage({super.key, required this.db, this.currentIndex = 0});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      PomodoroTimer(db: widget.db),
      Tasks(db: widget.db),
      SafeArea(child: Text("Settings")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[widget.currentIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            switch (value) {
              case 0:
                widget.currentIndex = 0;
              case 1:
                widget.currentIndex = 1;
              case 2:
                widget.currentIndex = 2;
              default:
            }
          });
        },
        selectedIndex: widget.currentIndex,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.timer),
            label: "Pomodoro Timer",
          ),
          NavigationDestination(icon: Icon(Icons.task), label: "Tasks"),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: "Einstellungen",
          ),
        ],
      ),
      floatingActionButton: widget.currentIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddTask(
                      db: widget.db,
                      onAdd: (title, time) {
                        widget.db.addTask(Task(title: title, time: time));
                      },
                      onEdit: (title, time) {},
                    ),
                  ),
                );
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
