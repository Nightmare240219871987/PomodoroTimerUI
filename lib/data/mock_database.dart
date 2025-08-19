import 'package:pomodoro_timer_ui/common/task.dart';
import 'package:pomodoro_timer_ui/data/database_repo.dart';

class MockDatabase extends DatabaseRepo {
  final List<Task> _tasks = [];

  @override
  Future<void> writeTask(Task t) async {
    _tasks.add(t);
  }

  @override
  Future<void> deleteTask(int index) async {
    _tasks.removeAt(index);
  }

  @override
  String? readTaskTitleFromIndex(int index) {
    if (_tasks.isEmpty) {
      return "";
    }
    return _tasks.elementAt(index).taskTitle;
  }

  @override
  List<Task?> readTasks() {
    return _tasks;
  }

  @override
  double? readTimeFromIndex(int index) {
    if (_tasks.isEmpty) {
      return 0;
    }
    return _tasks.elementAt(index).timeMin;
  }

  @override
  void initDb() {
    // TODO: implement initDb
  }

  @override
  void closeDB() {
    // TODO: implement closeDB
  }

  @override
  void writeTasks() {
    // TODO: implement writeTasks
  }
}
