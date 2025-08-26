import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pomodoro_timer_ui/src/common/task.dart';
import 'package:pomodoro_timer_ui/src/data/database_repository.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart' as p;

class Sqlite3Database extends DatabaseRepository {
  // Cache bzw. Lokale Liste
  final List<Task> _tasks = [];
  late Database _db;

  // SQL Statements
  final String createTasksTable =
      "CREATE TABLE tasks (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, time REAL NOT NULL);";
  final String findTaskTable =
      "SELECT name FROM sqlite_master WHERE type='table' AND name='tasks'";
  final String loadAllTasks = "SELECT title,time FROM tasks";
  final String saveAllTasks = "INSERT INTO tasks (title,time) VALUES(?, ?)";
  final String deleteTasksTable = "DROP TABLE IF EXISTS tasks;";

  void _createTasksTable() {
    ResultSet result = _db.select(findTaskTable);
    if (result.isEmpty) {
      _db.execute(createTasksTable);
    }
  }

  void _deleteTasksTable() {
    _db.execute(deleteTasksTable);
  }

  @override
  void addTask(Task t) {
    _tasks.add(t);
    writeTasks();
  }

  @override
  void close() {}

  @override
  void editTask(int index, Task t) {
    _tasks[index] = t;
    writeTasks();
  }

  @override
  Future<void> initialize() async {
    Directory path = await getApplicationDocumentsDirectory();
    String combinedPath = p.join(path.path, "tasks.db");
    _db = sqlite3.open(combinedPath);
    _createTasksTable();
    readTasks();
  }

  @override
  void insertTask(int index, Task t) {
    _tasks.insert(index, t);
    writeTasks();
  }

  @override
  Task? readTask(int index) {
    return _tasks.elementAtOrNull(index);
  }

  @override
  List<Task> readTasks() {
    _tasks.clear();
    ResultSet result = _db.select(loadAllTasks);
    for (Map m in result) {
      _tasks.add(Task(title: m["title"], time: m["time"]));
    }
    return _tasks;
  }

  @override
  void removeTask(int index) {
    _tasks.removeAt(index);
    writeTasks();
  }

  @override
  void writeTasks() {
    // Löschen und neuerstellen der tasks tabelle
    _deleteTasksTable();
    _createTasksTable();
    // Liste wird in die Datenbank gespeichert.
    PreparedStatement stmt = _db.prepare(saveAllTasks);
    for (Task t in _tasks) {
      stmt.execute([t.title, t.time]);
    }
    stmt.dispose();
  }

  @override
  int getDbLength() {
    return _tasks.length;
  }
}
