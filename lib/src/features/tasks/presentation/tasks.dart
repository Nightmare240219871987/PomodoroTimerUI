import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro_timer_ui/src/common/task.dart';
import 'package:pomodoro_timer_ui/src/data/database_repository.dart';
import 'package:pomodoro_timer_ui/src/features/tasks/domain/task_card.dart';
import 'package:pomodoro_timer_ui/src/features/tasks/presentation/add_task.dart';

// ignore: must_be_immutable
class Tasks extends StatefulWidget {
  late DatabaseRepository db;

  Tasks({super.key, required this.db});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  Timer? refreshTimer;
  @override
  void initState() {
    super.initState();
    refreshTimer = Timer.periodic(Duration(milliseconds: 500), _run);
  }

  _run(Timer t) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text("Tasks", style: TextStyle(fontSize: 28)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: widget.db.getDbLength(),
                itemBuilder: (context, index) {
                  return TaskCard(
                    title: widget.db.readTask(index) == null
                        ? ""
                        : widget.db.readTask(index)!.title,
                    time: widget.db.readTask(index) == null
                        ? 0
                        : widget.db.readTask(index)!.time,
                    index: index,
                    onEdit: (index) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddTask(
                            edit: true,
                            db: widget.db,
                            onAdd: (title, time) {
                              setState(() {
                                widget.db.addTask(
                                  Task(title: title, time: time),
                                );
                              });
                            },
                            onEdit: (title, time) {
                              setState(() {
                                widget.db.editTask(
                                  index,
                                  Task(title: title, time: time),
                                );
                              });
                            },
                            title: widget.db.readTask(index)!.title,
                            time: widget.db.readTask(index)!.time,
                          ),
                        ),
                      );
                    },
                    onDelete: (index) {
                      setState(() {
                        widget.db.removeTask(index);
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
