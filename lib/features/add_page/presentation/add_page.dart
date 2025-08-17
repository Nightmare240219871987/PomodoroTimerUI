import 'package:flutter/material.dart';
import 'package:pomodoro_timer_ui/common/task.dart';
import 'package:pomodoro_timer_ui/data/database_repo.dart';

// ignore: must_be_immutable
class AddPage extends StatefulWidget {
  void Function(Task)? onAdd = null;
  AddPage({super.key, this.onAdd});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController taskTitleCtrl = TextEditingController();

  final TextEditingController timeMinCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hinzufügen")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: taskTitleCtrl,
                    decoration: InputDecoration(
                      labelText: "Task Title",
                      hintText: "Geben Sie einen Task Title ein",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "das Feld darf nicht leer sein";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _formKey.currentState!.validate();
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: timeMinCtrl,
                    decoration: InputDecoration(
                      labelText: "Zeit",
                      hintText: "Geben Sie eine Zeit für den Timer ein",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      RegExp re = RegExp("[a-z][A-Z]*");
                      if (value != null && re.hasMatch(value)) {
                        return "Es sind nur Zahlen erlaubt.";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _formKey.currentState!.validate();
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Task t = Task(
                        taskTitle: taskTitleCtrl.text,
                        timeMin: double.tryParse(timeMinCtrl.text) ?? 0.0,
                      );
                      if (widget.onAdd != null) {
                        widget.onAdd!(t);
                      }
                      Navigator.pop(context);
                    },
                    child: Text("Hinzufügen"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
