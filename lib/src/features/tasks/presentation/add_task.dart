import 'package:flutter/material.dart';
import 'package:pomodoro_timer_ui/src/data/database_repository.dart';
import 'package:pomodoro_timer_ui/src/features/landing_page/presentation/landing_page.dart';

// ignore: must_be_immutable
class AddTask extends StatelessWidget {
  final DatabaseRepository db;
  final bool edit;
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _timeCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void Function(String title, double time) onEdit;
  void Function(String title, double time) onAdd;
  final String title;
  final double time;

  AddTask({
    super.key,
    required this.db,
    required this.onEdit,
    required this.onAdd,
    this.edit = false,
    this.title = "",
    this.time = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (edit) {
      _titleCtrl.text = title;
      _timeCtrl.text = time.toString();
    }
    return Scaffold(
      appBar: AppBar(title: Text("Hinzufügen")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 8,
                children: [
                  TextFormField(
                    controller: _titleCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Title",
                      hintText: "Gib hier den Titel der Aufgabe ein",
                    ),
                  ),
                  TextFormField(
                    controller: _timeCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Time",
                      hintText: "Gib hier die Zeit der Aufgabe ein",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      edit
                          ? onEdit(
                              _titleCtrl.text,
                              double.parse(_timeCtrl.text),
                            )
                          : onAdd(
                              _titleCtrl.text,
                              double.parse(_timeCtrl.text),
                            );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LandingPage(db: db, currentIndex: 1),
                        ),
                      );
                    },
                    child: Text("Speichern"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
