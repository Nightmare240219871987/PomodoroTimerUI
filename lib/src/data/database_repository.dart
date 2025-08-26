import 'package:pomodoro_timer_ui/src/common/task.dart';

abstract class DatabaseRepository {
  Future<void> initialize();
  void close();

  List<Task> readTasks();
  void writeTasks();
  int getDbLength();

  void addTask(Task t);
  void insertTask(int index, Task t);
  Task? readTask(int index);
  void editTask(int index, Task t);
  void removeTask(int index);
}
