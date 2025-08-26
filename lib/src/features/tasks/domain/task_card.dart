import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskCard extends StatelessWidget {
  void Function(int index) onDelete;
  void Function(int index) onEdit;
  String title;
  double time;
  int index;

  TaskCard({
    super.key,
    required this.title,
    required this.time,
    this.index = 0,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.task_alt),
        subtitle: Column(
          children: [
            Text(title, style: TextStyle(fontSize: 16)),
            Text(
              "${time.toString()} Min",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                onEdit(index);
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                onDelete(index);
              },
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
