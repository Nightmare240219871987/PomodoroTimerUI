import 'package:pomodoro_timer_ui/common/task.dart';

abstract class DatabaseRepo {
  void initDb();
  void closeDB();

  void writeTask(Task t);

  double? readTimeFromIndex(int index);
  String? readTaskTitleFromIndex(int index);
  List<Task?> readTasks();
  void writeTasks();

  void deleteTask(int index);
}
