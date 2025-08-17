import 'package:pomodoro_timer_ui/common/task.dart';
import 'package:pomodoro_timer_ui/data/database_repo.dart';

class MockDatabase extends DatabaseRepo {
  final List<Task> _tasks = [];

  @override
  void createTask(Task t) {
    _tasks.add(t);
  }

  @override
  void deleteTask(int index) {
    _tasks.removeAt(index);
  }

  @override
  Task readTask(int index) {
    return _tasks.elementAt(index);
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
}
