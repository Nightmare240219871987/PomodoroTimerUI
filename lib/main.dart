import 'package:flutter/material.dart';
import 'package:pomodoro_timer_ui/src/app.dart';
import 'package:pomodoro_timer_ui/src/data/database_repository.dart';
import 'package:pomodoro_timer_ui/src/data/sqlite3_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseRepository db = Sqlite3Database();
  await db.initialize();
  runApp(MainApp(db: db));
}
