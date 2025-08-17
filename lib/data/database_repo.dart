import 'package:pomodoro_timer_ui/common/task.dart';

abstract class DatabaseRepo {
  void createTask(Task t);

  Task? readTask(int index);
  double? readTimeFromIndex(int index);
  String? readTaskTitleFromIndex(int index);
  List<Task?> readTasks();

  void deleteTask(int index);
}
