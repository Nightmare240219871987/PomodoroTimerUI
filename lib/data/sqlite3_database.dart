import 'dart:io';

import 'package:pomodoro_timer_ui/common/task.dart';
import 'package:pomodoro_timer_ui/data/database_repo.dart';
import 'package:sqlite3/sqlite3.dart';

class Sqlite3Database extends DatabaseRepo {
  late Database db;
  bool isInitialized = false;
  final List<Task> _tasks = [];
  final String dbName = "tasks.db";

  @override
  void closeDB() {}

  @override
  void writeTask(Task t) {
    _tasks.add(t);
    writeTasks();
  }

  @override
  void deleteTask(int index) {
    _tasks.removeAt(index);
    writeTasks();
  }

  @override
  void initDb() {
    db = sqlite3.open(dbName);
    var result = db.select(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='tasks'",
    );
    if (result.isEmpty) {
      db.execute(''' 
        CREATE TABLE tasks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          taskTitle TEXT NOT NULL,
          time REAL NOT NULL
        );
      ''');
    }
    readTasks();
  }

  @override
  String? readTaskTitleFromIndex(int index) {
    if (_tasks.isNotEmpty) {
      return _tasks[index].taskTitle;
    }
    return "";
  }

  @override
  List<Task?> readTasks() {
    var result = db.select("SELECT taskTitle,time FROM tasks");
    if (_tasks.isEmpty && !isInitialized) {
      for (var row in result) {
        _tasks.add(Task(taskTitle: row["taskTitle"], timeMin: row["time"]));
      }
      isInitialized = true;
    }
    return _tasks;
  }

  @override
  double? readTimeFromIndex(int index) {
    if (_tasks.isNotEmpty) {
      return _tasks[index].timeMin;
    }
    return 0.0;
  }

  @override
  void writeTasks() {
    db.dispose();
    File(dbName).deleteSync();
    initDb();
    if (_tasks.isNotEmpty) {
      PreparedStatement stmt = db.prepare(
        "INSERT INTO tasks (taskTitle, time) VALUES (?, ?);",
      );
      for (Task t in _tasks) {
        stmt.execute([t.taskTitle, t.timeMin]);
      }
      stmt.dispose();
    }
    readTasks();
  }
}
